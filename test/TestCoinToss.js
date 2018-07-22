const CoinToss = artifacts.require("CoinToss");
const helper = require("./helpers/delorean");

const userBet = false;

contract('testing CoinToss contract', async (accounts) =>{
    it('should be deployed to the test chain', async() =>{
        let coinToss = await CoinToss.deployed();

        assert.isNotNull(coinToss);
    });

    it('should accept funds for the bankroll through the anonymous function', async() =>{
        let coinToss = await CoinToss.deployed();
        let expected = 2e16;

        web3.eth.sendTransaction({from: accounts[1], to: CoinToss.address, value: expected});

        let actual = await coinToss.bankroll.call();

        assert.equal(actual, expected);
    });

    it('should accept funds for the bankroll through the fund function', async() =>{
        let coinToss = await CoinToss.deployed();
        let fundingIncrease = 5e16;
        let currentBalance = await coinToss.bankroll.call();
        let expected = fundingIncrease + parseInt(currentBalance);

        await coinToss.fund({from: accounts[1], value: fundingIncrease});

        let actual = await coinToss.bankroll.call();

        assert.equal(actual, expected);
    });

    it('should accept an appropriately sized bet', async() =>{
        let coinToss = await CoinToss.deployed();
        let amountToBet = 4e14;

        await coinToss.placeBet(userBet, {from: accounts[1], value: amountToBet})

        let count  = await coinToss.counter.call();

        assert.equal(count, 1);
    });

    it('the blockchain should be moved on by a few blocks', async() =>{
        let numberOfBlocksToAdvance = 6;
        let initialBlock = web3.eth.getBlock('latest').number;
        let expected = parseInt(initialBlock) + numberOfBlocksToAdvance;

        for (i = 0; i < numberOfBlocksToAdvance; i++) {
            await helper.advanceBlock();
        }

        let actual = web3.eth.getBlock('latest').number;

        assert.equal(actual, expected);
    });

    it('should correctly identify a winning bet', async() =>{
        let coinToss = await CoinToss.deployed();
        let tossResult = await coinToss.getRandomForBet(1);
        let expected = !!parseInt(tossResult) === userBet;

        let actual = await coinToss.getResultForBet(1);

        assert.equal(expected, actual);
    });
});
