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

Here are the results of the code coverage for the Pool contract:

[⠊] Compiling...
[⠰] Compiling 27 files with Solc 0.8.24
[⠑] Solc 0.8.24 finished in 3.28s
Compiler run successful!
Analysing contracts...
Running tests...

Ran 15 tests for `test/Pool.t.sol:PoolTest`
[<p style="color:green">PASS</p>] test_ContractDeployedSuccessfully() (gas: 25,186)
[PASS] test_ExpectEmit_SuccessfullContribute(uint96) (runs: 257, μ: 70,045, ~: 70,045)
[PASS] test_RevertWhen_CollectNotFinished() (gas: 104,457)
[PASS] test_RevertWhen_EndIsReached() (gas: 23,015)
[PASS] test_RevertWhen_GoalAlreadyReached() (gas: 108,482)
[PASS] test_RevertWhen_GoalIsNotReached() (gas: 77,305)
[PASS] test_RevertWhen_GoalIsReachedButEndIsNotReached() (gas: 73,290)
[PASS] test_RevertWhen_NoContribution() (gas: 77,309)
[PASS] test_RevertWhen_NotEnoughFounds() (gas: 14,527)
[PASS] test_RevertWhen_NotTheOwner() (gas: 14,437)
[PASS] test_RevertWhen_RefundFailedToSendEther() (gas: 93,279)
[PASS] test_RevertWhen_WithdrawFailedSendEther() (gas: 762,150)
[PASS] test_RevertWith_EndIsNotReached() (gas: 15,959)
[PASS] test_refund() (gas: 95,734)
[PASS] test_withdraw() (gas: 121,379)

Suite result: OK. 15 passed; 0 failed; 0 skipped; finished in 48.80ms (56.25ms CPU time)

Ran 1 test suite in 50.39ms (48.80ms CPU time): 15 tests passed, 0 failed, 0 skipped (15 total tests)

| File         | % Lines         | % Statements    | % Branches    | % Funcs       |
|--------------|-----------------|-----------------|---------------|---------------|
| src/Pool.sol | 100.00% (26/26) | 100.00% (30/30) | 100.00% (8/8) | 100.00% (4/4) |
| **Total**    | **100.00% (26/26)** | **100.00% (30/30)** | **100.00% (8/8)** | **100.00% (4/4)** |


### License

This project is licensed under the MIT License. See the LICENSE file for details.