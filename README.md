# EdgeFund Core Platform

![logo](/assets/edgefund.png "EdgeFundLogo")

This repository contains the core smart contracts used on the EdgeFund platform, including tests and truffle local development tools.

## Prerequisites

In order to run these contracts you need to have the following installed and configured.

* nodejs & npm
* truffle

It is assumed you are already familiar with nodejs and npm.  To install truffle please run the following command.

`npm install -g truffle`

Once you have truffle installed globally you need to install the local prerequisites, you can do this simply by running

`npm install`

Now you should have everything you need and be ready to start compiling and testing the contracts.

## Running the contracts

Before you can run the tests for the contracts they need to be compiled. To compile the contracts run the following command.

`truffle compile`

Once the contracts are compiled you can run the tests by running.

`truffle test`
