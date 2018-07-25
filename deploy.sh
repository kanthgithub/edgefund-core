#!/usr/bin/env bash
npm install -g truffle
npm install

truffle migrate -f 3 --network rinkeby # 3 refers to migrations/3_deploy_cointoss.js
