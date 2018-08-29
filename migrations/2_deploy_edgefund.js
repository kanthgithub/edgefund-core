const EdgeFundBettingFunctions = artifacts.require('./EdgeFundBettingFunctions.sol');
const EdgeFund = artifacts.require('./EdgeFund.sol');
const CoinTossMock = artifacts.require('./CoinTossMock.sol');

module.exports = function (deployer) {
    return deployer.then(async () => {
        await deployer.deploy(EdgeFund);
        await deployer.deploy(EdgeFundBettingFunctions);
        await deployer.deploy(CoinTossMock);
    });
};
