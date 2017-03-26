# openticket-contracts

## How to run with TestRpc and Truffle:

1. Install [TestRpc](https://github.com/ethereumjs/testrpc#docker). This is your local in-mem blockchain.
  * `git clone https://github.com/ethereumjs/testrpc.git && cd testrpc`
  * `docker build -t ethereumjs/testrpc .`

2. Start TestRpc. Starts mapped to port 8545.
  * `docker run -d -p 8545:8545 ethereumjs/testrpc:latest`

3. Install [truffle](https://github.com/trufflesuite/truffle). This is a framework for building, deploying, and testing Solidity applications.
  * `npm install -g truffle`

4. Run the tests.
  * `cd openticket-contracts && truffle test`
