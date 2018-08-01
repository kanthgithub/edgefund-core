const CoinToss = artifacts.require('CoinToss');
const helper = require('./helpers/delorean');
const expectThrow = require('./helpers/throwHandler');
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

    it('should reject a bet above the MAXIMUM_BET_SIZE', async () => {
        const coinToss = await CoinToss.deployed();
        const maxBet = await coinToss.MAXIMUM_BET_SIZE.call();
        const amountToBet = maxBet * 2;
        const placeBet = coinToss.placeBet(userBet, { from: accounts[1], value: amountToBet });

        await expectThrow(placeBet);
    });

    it('should reject resolveBet call from incorrect address', async () => {
        await testResolveBetRequires(123, accounts, 2, 6);
    });

    it('should reject resolveBet call with insufficient blocks passed', async () => {
        await testResolveBetRequires(123, accounts, 1, 2);
    });

    it('should reject resolveBet call with too many blocks passed', async () => {
        await testResolveBetRequires(123, accounts, 1, 11);
    });

    it('should advance the blockchain by a few blocks', async () => {
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

    it('should return the same from the constant and the function', async () => {
        const coinToss = await CoinToss.deployed();

        const maxBetFromConst = parseInt(await coinToss.MAXIMUM_PASSED_BLOCKS.call());
        const maxBetFromFunction = parseInt(await coinToss.getMaxPassedBlocks());

        assert.equal(maxBetFromConst, maxBetFromFunction);
    });

    it('should not self destruct from non-owner address', async () => {
        const coinToss = await CoinToss.deployed();

        await expectThrow(coinToss.kill({ from: accounts[2] }));
    });

    it('should selfdestruct', async () => {
        const coinToss = await CoinToss.deployed();

        let noError = false;

        try {
            await coinToss.kill();
            noError = true;
        } catch (err) {
            noError = false;
        }

        assert.isTrue(noError);
    });
});

// Helper functions
const testResolveBetRequires = async (betId, accounts, accountNumber, blockToAdvance) => {
    const coinTossMock = await CoinTossMock.deployed();
    const amountToBet = 4e14;

    await coinTossMock.fund({ from: accounts[1], value: 1e15 });
    await coinTossMock.setBetId(betId);
    await coinTossMock.placeBet(userBet, { from: accounts[1], value: amountToBet });
    await helper.advanceMultipleBlocks(blockToAdvance);

    await expectThrow(coinTossMock.resolveBet(betId, { from: accounts[accountNumber] }));
};

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
