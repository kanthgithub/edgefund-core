const CoinToss = artifacts.require('./CoinToss.sol');

module.exports = function (deployer) {
    return deployer.then(async () => {
        await deployer.deploy(CoinToss);
    });
};
