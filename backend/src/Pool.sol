// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/// @title Foundry Pool
/// @notice This contract implements a simple crowdfunding pool where users can contribute ether.
/// @dev The contract uses OpenZeppelin's Ownable for ownership management.
/// @author CecileH75

import "@openzeppelin/contracts/access/Ownable.sol";

error CollectIsFinished();
error GoalAlreadyReached();
error CollectNotFinished();
error FailedToSendEther();
error NoContribution();
error NotEnoughFounds();

contract Pool is Ownable {
    /// @notice The timestamp when the fundraising ends
    uint256 public end;
    
    /// @notice The goal amount to be raised in the pool (in wei)
    uint256 public goal;
    
    /// @notice The total amount of ether collected so far (in wei)
    uint256 public totalCollected;

    /// @notice Mapping to track each contributor's contribution (address => amount)
    mapping(address => uint256) public contributions;

    /// @notice Event emitted when a contribution is made
    /// @param contributor The address of the contributor
    /// @param amount The amount of ether contributed (in wei)
    event Contribute(address indexed contributor, uint256 amount);

    /// @notice Constructor to initialize the pool with a duration and goal
    /// @param _duration The duration of the fundraising (in seconds)
    /// @param _goal The target amount to be collected (in wei)
    constructor(uint256 _duration, uint256 _goal) Ownable(msg.sender) {
        end = block.timestamp + _duration;
        goal = _goal;
    }

    /// @notice Allows a user to contribute to the pool by sending ether
    /// @dev Reverts if the fundraising has ended or if the sent value is zero
    function contribute() external payable {
        if (block.timestamp >= end) {
            revert CollectIsFinished();
        }
        if (msg.value == 0) {
            revert NotEnoughFounds();
        }

        contributions[msg.sender] += msg.value;
        totalCollected += msg.value;

        emit Contribute(msg.sender, msg.value);
    }

    /// @notice Allows the owner to withdraw the total amount collected if the goal is reached
    /// @dev Reverts if the fundraising is still ongoing or if the goal is not reached
    function withdraw() external onlyOwner {
        if (block.timestamp > end || totalCollected < goal) {
            revert CollectNotFinished();
        }

        (bool sent,) = msg.sender.call{value: address(this).balance}("");
        if (!sent) {
            revert FailedToSendEther();
        }
    }

    /// @notice Allows contributors to request a refund if the goal is not reached
    /// @dev Reverts if the fundraising is still ongoing or if the goal is already reached
    function refund() external {
        if (block.timestamp < end) {
            revert CollectNotFinished();
        }

        if (totalCollected >= goal) {
            revert GoalAlreadyReached();
        }
        if (contributions[msg.sender] == 0) {
            revert NoContribution();
        }   

        uint256 amount = contributions[msg.sender];
        contributions[msg.sender] = 0;
        totalCollected -= amount;
        (bool sent,) = msg.sender.call{value: amount}("");
        if (!sent) {
            revert FailedToSendEther();
        }
    }
}
