const CoinToss = artifacts.require('CoinToss');
const helper = require('./helpers/delorean');
const CoinTossMock = artifacts.require('CoinTossMock');
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

        assert.equal(expected, actual);
    });

    // Passing an even betID results in a 'win' from the mocked functions.
    it('should NOT pay out with bet tails, is heads', async () => {
        const balanceDifference = await testPossibleStates(true, 1, accounts);

        assert(balanceDifference < -1);
    });

    it('should correctly pay out with bet heads, is heads', async () => {
        const balanceDifference = await testPossibleStates(true, 0, accounts);

        assert(balanceDifference > 0.98);
    });

    it('should NOT pay out with bet heads, is tails', async () => {
        const balanceDifference = await testPossibleStates(false, 0, accounts);

        assert(balanceDifference < -1);
    });

    it('should correctly pay out with bet tails, is tails', async () => {
        const balanceDifference = await testPossibleStates(false, 1, accounts);

        assert(balanceDifference > 0.98);
    });
});

// Helper functions

const testPossibleStates = async (bet, betID, accounts) => {
    const coinTossMock = await CoinTossMock.deployed();
    const initialValueAcc2 = web3.fromWei(web3.eth.getBalance(web3.eth.accounts[2]));
    const numberOfBlocksToAdvance = 6;

    await coinTossMock.fund({ from: accounts[1], value: 25e17 });
    await coinTossMock.setBetId(betID);

    await coinTossMock.placeBet(bet, { from: accounts[2], value: 1e18 });
    await helper.advanceMultipleBlocks(numberOfBlocksToAdvance);
    await coinTossMock.resolveBet(betID, { from: accounts[2] });

    const finalBalanceAcc2 = web3.fromWei(web3.eth.getBalance(web3.eth.accounts[2]));

    return (finalBalanceAcc2 - initialValueAcc2);
};
