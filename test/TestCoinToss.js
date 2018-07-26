const CoinToss = artifacts.require('CoinToss');
const helper = require('./helpers/delorean');
const userBet = false;

contract('testing CoinToss contract', async (accounts) => {
    it('should be deployed to the test chain', async () => {
        const coinToss = await CoinToss.deployed();

        assert.isNotNull(coinToss);
    });

    it('should accept funds for the bankroll through the anonymous function', async () => {
        const coinToss = await CoinToss.deployed();
        const expected = 2e16;

        web3.eth.sendTransaction({ from: accounts[1], to: CoinToss.address, value: expected });

        const actual = await coinToss.bankroll.call();

        assert.equal(actual, expected);
    });

    it('should accept funds for the bankroll through the fund function', async () => {
        const coinToss = await CoinToss.deployed();
        const fundingIncrease = 5e16;
        const currentBalance = await coinToss.bankroll.call();
        const expected = fundingIncrease + parseInt(currentBalance);

        await coinToss.fund({ from: accounts[1], value: fundingIncrease });

        const actual = await coinToss.bankroll.call();

        assert.equal(actual, expected);
    });

    it('should accept an appropriately sized bet', async () => {
        const coinToss = await CoinToss.deployed();
        const amountToBet = 4e14;

        await coinToss.placeBet(userBet, { from: accounts[1], value: amountToBet });

        const count = await coinToss.counter.call();

        assert.equal(count, 1);
    });

    it('the blockchain should be moved on by a few blocks', async () => {
        const numberOfBlocksToAdvance = 6;
        const initialBlock = web3.eth.getBlock('latest').number;
        const expected = parseInt(initialBlock) + numberOfBlocksToAdvance;

        for (let i = 0; i < numberOfBlocksToAdvance; i++) {
            await helper.advanceBlock();
        }

        const actual = web3.eth.getBlock('latest').number;

        assert.equal(actual, expected);
    });

    it('should correctly identify a winning bet', async () => {
        const coinToss = await CoinToss.deployed();
        const tossResult = await coinToss.getRandomForBet(1);
        const expected = !!parseInt(tossResult) === userBet;
        const actual = await coinToss.getResultForBet(1);

        assert.equal(expected, actual);
    });
});
