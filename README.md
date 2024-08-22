# Foundry Pool Contract

This project implements a simple crowdfunding pool using the Solidity programming language. The contract allows users to contribute Ether to a pool, with the goal of reaching a specified amount within a certain timeframe. If the goal is reached, the owner can withdraw the collected funds. If the goal is not reached by the end of the timeframe, contributors can request a refund.

## Table of Contents

- [Foundry Pool Contract](#foundry-pool-contract)
  - [Table of Contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Usage](#usage)
    - [Running Tests](#running-tests)
    - [Coverage](#coverage)
    - [Deployment](#deployment)
      - [Deployment Details](#deployment-details)
  - [License](#license)

## Project Overview

The `Pool` contract is a simple crowdfunding contract where:

- Users can contribute Ether to a common pool.
- The owner can withdraw funds if a specified goal is reached.
- If the goal is not reached by the end of the contribution period, contributors can request a refund.

## Getting Started

### Prerequisites

To work with this project, you will need:

- [Foundry](https://getfoundry.sh/) - A blazing fast, portable and modular toolkit for Ethereum application development.
- [Solidity](https://docs.soliditylang.org/) - The smart contract programming language.
- [OpenZeppelin Contracts](https://openzeppelin.com/contracts/) - A library for secure smart contract development.

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/Cecile-Hirschauer/foundry-pool.git
    cd foundry-pool
    ```

2. Install the necessary dependencies:

    ```bash
    forge install
    ```

## Usage

### Running Tests

To run the tests for the `Pool` contract, use the following command:

```bash
forge test
```

This will execute all test cases written for the contract. The test suite ensures that all functionalities of the contract are working as expected. The tests cover a variety of scenarios, including successful contributions, withdrawals, and refunds, as well as edge cases where the contract should revert.

### Coverage

After running the tests, you can check the code coverage by running:

```bash
forge coverage

```

### Deployment

To deploy the Pool contract, use the deployment script provided in the script directory. You can deploy the contract using the following command:

```bash
forge script script/Deploy.s.sol:MyScript --fork-url http://127.0.0.1:8545 --broadcast

```

#### Deployment Details

- **Estimated Gas Used:** 562,534
- **Estimated ETH Required:** 0.001125068 ETH
- **Contract Address:** 0x5FbDB2315678afecb367f032d93F642f64180aa3
- **Block:** 1
- **Gas Paid:** 432,831 gas * 1.000000001 gwei = 0.000432831 ETH

The deployment transaction is saved in:

- **Transactions:** broadcast/Deploy.s.sol/31337/run-latest.json
- **Sensitive Values:** cache/Deploy.s.sol/31337/run-latest.json

**Note:** The deployment was successful, but it's important to verify that the deployed contract is functioning as expected in your specific environment.


![image](https://github.com/user-attachments/assets/7aac381e-644b-4b96-b760-e3ee646d0364)

## License

This project is licensed under the MIT License. See the LICENSE file for details.
