const EdgeFundBettingFunctions = artifacts.require('./EdgeFundBettingFunctions.sol');
const EdgeFund = artifacts.require("./EdgeFund.sol");
const CoinToss = artifacts.require("./CoinToss.sol");

module.exports = function(deployer) {
    return deployer.then(async () =>
    {
        await deployer.deploy(EdgeFund);
        await deployer.deploy(EdgeFundBettingFunctions);
        await deployer.deploy(CoinToss);
    });
}
