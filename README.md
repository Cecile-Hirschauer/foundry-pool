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

### Usage


### License

This project is licensed under the MIT License. See the LICENSE file for details.