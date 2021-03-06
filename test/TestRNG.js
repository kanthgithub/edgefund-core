const CoinToss = artifacts.require('CoinToss');
const utils = require('web3-utils');

web3.utils = utils;

contract('Testing the RNG function', async () => {
    it('should generate a 0 result for hash Hello World! and BetId 0', testHelloWorld);
    it('should generate a 1 result for hash EdgeFund and BetId 0', testEdgeFund);
});

async function testHelloWorld() {
    const coinToss = await CoinToss.deployed();
    const hash = 'Hello World!';
    const betId = 0;
    const expected = (parseInt(web3.utils.soliditySha3(hash, betId)) % 2) === 0;

    const actual = await coinToss.getResultForBet(betId, hash);

    assert.equal(expected, actual);
}

async function testEdgeFund() {
    const coinToss = await CoinToss.deployed();
    const hash = 'EdgeFund!';
    const betId = 0;
    const expected = (parseInt(web3.utils.soliditySha3(hash, betId)) % 2) === 0;

    const actual = await coinToss.getResultForBet(betId, hash);

    assert.equal(expected, actual);
}
