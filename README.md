# EdgeFund Core Platform

![logo](/assets/edgefund.png "EdgeFundLogo")

[![Travis](https://img.shields.io/travis/edgefund/edgefund-core.svg)](https://travis-ci.org/edgefund/edgefund-core)
[![Twitter Follow](https://img.shields.io/twitter/follow/edgefundteam.svg?style=social&label=Follow)](https://www.twitter.com/edgefundteam)

This repository contains the core smart contracts used on the EdgeFund platform, including tests and truffle local development tools.

## Prerequisites

In order to run these contracts you need to have the following installed and configured.

* nodejs & npm
* truffle
* Docker (Optional)

It is assumed you are already familiar with nodejs and npm.  To install truffle please run the following command:

`npm install -g truffle`

Once you have truffle installed globally you need to install the local prerequisites, you can do this simply by running:

`npm install`

Now you should have everything you need and be ready to start compiling and testing the contracts.

## Running the contracts

Before you can run the tests for the contracts they need to be compiled. To compile the contracts run the following command:

`truffle compile`

## Setting up a local test blockchain

In order to run the tests we need to have a blockchain against which to run them.  Thankfully ganache-cli
allows us to run a local 'mock' blockchain which we can manipulate in order to forward time, mine a predictable
amount of blocks and so on.  This level of control allows us to have predictable conditions under which to run
our tests.

## Setup a local ganache-cli server

Now that you have truffle installed globally, you can startup a local test blockchain by running the following:

`truffle develop`

You will need to open a new terminal window after this point, to be able to run further commands, but to allow
the test server to remain running.  If you close the window where this command was run, your test suite will not
be able to find the test server.

## Setting up a ganache-cli blockchain in Docker

Simply run the following command:

`docker run -d -p 8545:8545 trufflesuite/ganache-cli:latest -a 10 -h 0.0.0.0`

This will start-up a docker container which runs the blockchain, exposing it on port 8545.  So make sure
your `truffle.js` configuration matches this port.

## Running the Tests

Once the contracts are compiled and your server is started, you can run the tests by running:

`truffle test`
