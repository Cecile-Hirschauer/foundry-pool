// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Script.sol";
import {Pool} from "../src/Pool.sol";

/// @title Deployment Script for Pool Contract
/// @notice This script deploys the Pool contract using Foundry's scripting tools
contract MyScript is Script {
    /// @notice Executes the deployment script
    /// @dev This function retrieves the deployer's private key from the environment variables and uses it to deploy the Pool contract with a predefined duration and goal.
    function run() external {
        // Retrieve the deployer's private key from the environment variables
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // Begin broadcasting transactions to the blockchain using the deployer's private key
        vm.startBroadcast(deployerPrivateKey);

        // Define the parameters for the Pool contract deployment
        uint256 duration = 4 weeks; // Duration of the pool
        uint256 goal = 10 ether; // Goal to reach in the pool (in ether)

        // Deploy the Pool contract with the specified duration and goal
        Pool pool = new Pool(duration, goal);

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}
