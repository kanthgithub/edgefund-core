#!/usr/bin/env bash
npm install -g truffle

# 3 refers to migrations/3_deploy_cointoss.js
export ADDRESS=`truffle migrate -f 3 --network rinkeby
