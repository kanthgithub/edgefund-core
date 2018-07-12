const EdgeFundPOC = artifacts.require('./EdgeFundPOC.sol');
const EdgeTestCrowdSale = artifacts.require('./EdgeTestCrowdSale.sol');
const EdgeTestCoin = artifacts.require('./EdgeTestCoin.sol');
const EdgeFund = artifacts.require("./EdgeFund.sol");


module.exports = function(deployer, network, accounts) {
    const openingTime = web3.eth.getBlock('latest').timestamp + 2; // two secs in the future
    const closingTime = openingTime + 86400 * 20; // 20 days
    const rate = new web3.BigNumber(1000);
    const wallet = accounts[1];

    return deployer
        .then(() => {
            return deployer.deploy(EdgeTestCoin);
        })
        .then(() => {
            return deployer.deploy(
                EdgeTestCrowdSale,
                openingTime,
                closingTime,
                rate,
                wallet,
                EdgeTestCoin.address
            );
        }).then(() => {
            return deployer.deploy(EdgeFund);
        }).then(() => {
            return deployer.deploy(EdgeFundPOC);
        })
};
