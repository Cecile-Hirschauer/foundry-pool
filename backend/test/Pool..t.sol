// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import {Pool} from "../src/Pool.sol";

contract PoolTest is Test {
    // Define test addresses
    address owner = makeAddr("User0");
    address addr1 = makeAddr("User1");
    address addr2 = makeAddr("User2");
    address addr3 = makeAddr("User3");

    // Define test parameters
    uint256 duration = 4 weeks; // Duration of the pool in seconds
    uint256 goal = 10 ether; // Goal to reach in the pool (in ether)

    Pool pool;

    // Setup function to deploy the Pool contract before each test
    function setUp() public {
        vm.prank(owner);
        pool = new Pool(duration, goal);
    }

    // Test if the contract is deployed successfully with the correct parameters
    function test_ContractDeployedSuccessfully() public view {
        // Check if the owner is set correctly
        address _owner = pool.owner();
        assertEq(owner, _owner);

        // Check if the end timestamp is set correctly
        uint256 _end = pool.end();
        assertEq(block.timestamp + duration, _end);

        // Check if the goal is set correctly
        uint256 _goal = pool.goal();
        assertEq(goal, _goal);
    }

    // Test if the contract reverts when trying to contribute after the end time
    function test_RevertWhen_EndIsReached() public {
        // Fast forward time to after the end of the pool
        vm.warp(pool.end() + 3600);

        // Expect the CollectIsFinished error to be thrown
        bytes4 selector = bytes4(keccak256("CollectIsFinished()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a contribution from addr1
        vm.prank(addr1);
        vm.deal(addr1, 1 ether);
        pool.contribute{value: 1 ether}();
    }

    // Test if the contract reverts when trying to contribute with zero funds
    function test_RevertWhen_NotEnoughFounds() public {
        // Expect the NotEnoughFounds error to be thrown
        bytes4 selector = bytes4(keccak256("NotEnoughFounds()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a contribution from addr2 with zero ether
        vm.prank(addr2);
        vm.deal(addr2, 1 ether);
        pool.contribute();
    }

    // Test if the Contribute event is emitted correctly upon successful contribution
    function test_ExpectEmit_SuccessfullContribute(uint96 _amount) public {
        // Only test if the amount is greater than zero
        vm.assume(_amount > 0);

        // Expect the Contribute event to be emitted with correct parameters
        vm.expectEmit(true, false, false, true);
        emit Pool.Contribute(address(addr1), _amount);

        // Simulate a contribution from addr1
        vm.prank(addr1);
        vm.deal(addr1, _amount);
        pool.contribute{value: _amount}();
    }

    // Test if the contract reverts when a non-owner tries to withdraw funds
    function test_RevertWhen_NotTheOwner() public {
        // Expect the OwnableUnauthorizedAccount error to be thrown
        bytes4 selector = bytes4(
            keccak256("OwnableUnauthorizedAccount(address)")
        );
        vm.expectRevert(abi.encodeWithSelector(selector, addr1));

        // Simulate a withdrawal attempt from addr1 (non-owner)
        vm.prank(addr1);
        pool.withdraw();
    }

    // Test if the contract reverts when trying to withdraw before the end time
    function test_RevertWith_EndIsNotReached() public {
        // Expect the CollectNotFinished error to be thrown
        bytes4 selector = bytes4(keccak256("CollectNotFinished()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a withdrawal attempt by the owner before the end time
        vm.prank(owner);
        pool.withdraw();
    }

    // Test if the contract reverts when trying to withdraw if the goal is not reached
    function test_RevertWhen_GoalIsNotReached() public {
        // Simulate contributions that do not reach the goal
        vm.prank(addr1);
        vm.deal(addr1, 5 ether);
        pool.contribute{value: 5 ether}();

        // Fast forward time to after the end of the pool
        vm.warp(pool.end() + 3600);

        // Expect the CollectNotFinished error to be thrown
        bytes4 selector = bytes4(keccak256("CollectNotFinished()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a withdrawal attempt by the owner
        vm.prank(owner);
        pool.withdraw();
    }

    // Test if the contract reverts when trying to withdraw if the goal is reached but the end time is not reached
    function test_RevertWhen_GoalIsReachedButEndIsNotReached() public {
        // Simulate a contribution that reaches the goal
        vm.prank(addr1);
        vm.deal(addr1, 10 ether);
        pool.contribute{value: 10 ether}();

        // Expect the CollectNotFinished error to be thrown
        bytes4 selector = bytes4(keccak256("CollectNotFinished()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a withdrawal attempt by the owner before the end time
        vm.prank(owner);
        pool.withdraw();
    }

    // Test if the contract reverts when the withdraw fails due to a failed Ether transfer
    function test_RevertWhen_WithdrawFailedSendEther() public {
        pool = new Pool(duration, goal);

        // Simulate contributions that reach the goal
        vm.prank(addr1);
        vm.deal(addr1, 5 ether);
        pool.contribute{value: 5 ether}();

        vm.prank(addr2);
        vm.deal(addr2, 5 ether);
        pool.contribute{value: 5 ether}();

        // Fast forward time to after the end of the pool
        vm.warp(pool.end() + 3600);

        // Expect the FailedToSendEther error to be thrown
        bytes4 selector = bytes4(keccak256("FailedToSendEther()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a withdrawal attempt by the owner
        pool.withdraw();
    }

    // Test a successful withdrawal when the goal is reached and the end time has passed
    function test_withdraw() public {
        // Simulate contributions that reach the goal
        vm.prank(addr1);
        vm.deal(addr1, 5 ether);
        pool.contribute{value: 5 ether}();

        vm.prank(addr2);
        vm.deal(addr2, 5 ether);
        pool.contribute{value: 5 ether}();

        // Fast forward time to after the end of the pool
        vm.warp(pool.end() + 3600);

        // Simulate a successful withdrawal by the owner
        vm.prank(owner);
        uint256 balanceBeforeWithdraw = owner.balance;
        pool.withdraw();
        uint256 balanceAfterWithdraw = owner.balance;

        // Check balance of owner after withdrwaw.
        // Must be equal to sum of contributions and minimum equal to goal,
        // Here 10 ether
        assertEq(balanceBeforeWithdraw + 10 ether, balanceAfterWithdraw);
    }

    // Test if the contract reverts when trying to request a refund before the end time
    function test_RevertWhen_CollectNotFinished() public {
        // Simulate contributions that do not reach the goal
        vm.prank(addr1);
        vm.deal(addr1, 5 ether);
        pool.contribute{value: 5 ether}();

        vm.prank(addr2);
        vm.deal(addr2, 5 ether);
        pool.contribute{value: 2 ether}();

        // Expect the CollectNotFinished error to be thrown
        bytes4 selector = bytes4(keccak256("CollectNotFinished()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a refund request by addr1 before the end time
        vm.prank(addr1);
        pool.refund();
    }

    // Test if the contract reverts when trying to request a refund after the goal is reached
    function test_RevertWhen_GoalAlreadyReached() public {
        // Simulate contributions that reach the goal
        vm.prank(addr1);
        vm.deal(addr1, 5 ether);
        pool.contribute{value: 5 ether}();

        vm.prank(addr2);
        vm.deal(addr2, 5 ether);
        pool.contribute{value: 5 ether}();

        // Fast forward time to after the end of the pool
        vm.warp(pool.end() + 3600);

        // Expect the GoalAlreadyReached error to be thrown
        bytes4 selector = bytes4(keccak256("GoalAlreadyReached()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a refund request by addr1 after the goal is reached
        vm.prank(addr1);
        pool.refund();
    }

    // Test if the contract reverts when trying to request a refund with no contributions
    function test_RevertWhen_NoContribution() public {
        // Simulate a contribution from addr1
        vm.prank(addr1);
        vm.deal(addr1, 5 ether);
        pool.contribute{value: 5 ether}();

        // Fast forward time to after the end of the pool
        vm.warp(pool.end() + 3600);

        // Expect the NoContribution error to be thrown
        bytes4 selector = bytes4(keccak256("NoContribution()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a refund request from addr2 with no contributions
        vm.prank(addr2);
        pool.refund();
    }

    // Test if the contract reverts when the refund fails due to a failed Ether transfer
    function test_RevertWhen_RefundFailedToSendEther() public {
        // Deal some ether to this contract and simulate a contribution
        vm.deal(address(this), 2 ether);
        pool.contribute{value: 2 ether}();

        // Simulate a contribution from addr2
        vm.prank(addr2);
        vm.deal(addr2, 5 ether);
        pool.contribute{value: 5 ether}();

        // Fast forward time to after the end of the pool
        vm.warp(pool.end() + 3600);

        // Expect the FailedToSendEther error to be thrown
        bytes4 selector = bytes4(keccak256("FailedToSendEther()"));
        vm.expectRevert(abi.encodeWithSelector(selector));

        // Simulate a refund request from addr2
        pool.refund();
    }

    // Test a successful refund request when the goal is not reached and the end time has passed
    function test_refund() public {
        // Simulate a contribution from addr1
        vm.prank(addr1);
        vm.deal(addr1, 5 ether);
        pool.contribute{value: 1 ether}();

        // Simulate a contribution from addr2
        vm.prank(addr2);
        vm.deal(addr2, 5 ether);
        pool.contribute{value: 5 ether}();

        // Fast forward time to after the end of the pool
        vm.warp(pool.end() + 3600);

        uint256 balanceBeforerefund = addr1.balance;

        // Simulate a successful refund request from addr1
        vm.prank(addr1);
        pool.refund();

        uint256 balanceAfterRefund = addr1.balance;
        // Check if addr1 balance after refund is equal to 1 ether (its contribution)
        assertEq(balanceBeforerefund + 1 ether, balanceAfterRefund);
    }
}
