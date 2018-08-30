#!/usr/bin/env bash
npm install -g truffle

# 3 refers to migrations/3_deploy_cointoss.js
truffle migrate -f 3 --network rinkeby
