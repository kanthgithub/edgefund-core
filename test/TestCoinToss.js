const CoinToss = artifacts.require('CoinToss');
const { advanceBlock, advanceToBlock } = require('openzeppelin-solidity/test/helpers/advanceToBlock');
const expectThrow = require('./helpers/throwHandler');
const CoinTossMock = artifacts.require('CoinTossMock');
const userBet = false;

contract('testing CoinToss contract', async (accounts) => {
    it('should be deployed to the test chain', testDeploy);
    it('should accept funds for the bankroll through the anonymous function', fundTheContract(accounts));
    it('should accept funds for the bankroll through the fund function', fundTheContractThroughFundFunction(accounts));
    it('should accept an appropriately sized bet', acceptCorrectBet(accounts));
    it('should reject resolveBet call from incorrect address', testResolveBetRequires(123, accounts, 2, 6));
    it('should reject resolveBet call with insufficient blocks passed', testResolveBetRequires(123, accounts, 1, 2));
    it('should reject resolveBet call with too many blocks passed', testResolveBetRequires(123, accounts, 1, 11));
    it('should advance the blockchain by a few blocks', advanceAFewBlocks);
    it('should NOT pay out with bet tails, is heads', noPayTailsHeads(accounts));
    it('should correctly pay out with bet heads, is heads', payHeadsHeads(accounts));
    it('should NOT pay out with bet heads, is tails', noPayHeadsTails(accounts));
    it('should correctly pay out with bet tails, is tails', payTailsTails(accounts));
    it('should return the same from the constant and the function', returnSameFuncConst());
    it('should not self destruct from non-owner address', noSelfDestructNonOwner(accounts));
    it('should reject a bet above the maximumBetSize', rejectTooBigBet(accounts));
    it('should reject a bet it cannot afford to pay out', rejectBetBankrollTooSmall(accounts));
    it('should reject resolveBet call from incorrect address', rejectResolveBetWrongAddress(accounts));
    it('should selfdestruct', selfDestruct());
});

function selfDestruct() {
    return async () => {
        const coinToss = await CoinToss.deployed();

        let noError = false;

        try {
            await coinToss.kill();
            noError = true;
        } catch (err) {
            noError = false;
        }

        assert.isTrue(noError);
    };
}

function rejectResolveBetWrongAddress(accounts) {
    return async () => {
        await testResolveBetRequires(123, accounts, 2, 6);
    };
}

function rejectBetBankrollTooSmall(accounts) {
    return async () => {
        const coinToss = await CoinToss.deployed();
        const bankroll = await coinToss.bankroll.call();
        const tooBigBet = (parseInt(bankroll) / 2) + 10;
        const placeBet = coinToss.placeBet(userBet, { from: accounts[1], value: tooBigBet });

        await expectThrow(placeBet);
    };
}

function rejectTooBigBet(accounts) {
    return async () => {
        const coinToss = await CoinToss.deployed();
        const maxBet = await coinToss.maximumBetSize.call();
        const amountToBet = maxBet * 2;
        const placeBet = coinToss.placeBet(userBet, { from: accounts[1], value: amountToBet });

        await expectThrow(placeBet);
    };
}

function noSelfDestructNonOwner(accounts) {
    return async () => {
        const coinToss = await CoinToss.deployed();

        await expectThrow(coinToss.kill({ from: accounts[2] }));
    };
}

function returnSameFuncConst() {
    return async () => {
        const coinToss = await CoinToss.deployed();
        const maxBetFromConst = parseInt(await coinToss.MAXIMUM_PASSED_BLOCKS.call());
        const maxBetFromFunction = parseInt(await coinToss.getMaxPassedBlocks());

        assert.equal(maxBetFromConst, maxBetFromFunction);
    };
}

function payTailsTails(accounts) {
    return async () => {
        const balanceDifference = await testPossibleStates(false, 1, accounts);

        assert(balanceDifference > 0.98);
    };
}

function noPayHeadsTails(accounts) {
    return async () => {
        const balanceDifference = await testPossibleStates(false, 0, accounts);

        assert(balanceDifference < -1);
    };
}

function payHeadsHeads(accounts) {
    return async () => {
        const balanceDifference = await testPossibleStates(true, 0, accounts);

        assert(balanceDifference > 0.98);
    };
}

function noPayTailsHeads(accounts) {
    return async () => {
        const balanceDifference = await testPossibleStates(true, 1, accounts);

        assert(balanceDifference < -1);
    };
}

function fundTheContractThroughFundFunction(accounts) {
    return async () => {
        const coinToss = await CoinToss.deployed();
        const fundingIncrease = 5e16;
        const currentBalance = await coinToss.bankroll.call();
        const expected = fundingIncrease + parseInt(currentBalance);

        await coinToss.fund({ from: accounts[1], value: fundingIncrease });

        const actual = await coinToss.bankroll.call();

        assert.equal(actual, expected);
    };
}

function acceptCorrectBet(accounts) {
    return async () => {
        const coinToss = await CoinToss.deployed();
        const amountToBet = 4e14;

        await coinToss.placeBet(userBet, { from: accounts[1], value: amountToBet });
    };
}

function advanceAFewBlocks() {
    return async () => {
        const numberOfBlocksToAdvance = 6;
        const initialBlock = web3.eth.getBlock('latest').number;
        const expected = parseInt(initialBlock) + numberOfBlocksToAdvance;

        for (let i = 0; i < numberOfBlocksToAdvance; i++) {
            await advanceBlock();
        }

        const actual = web3.eth.getBlock('latest').number;

        assert.equal(expected, actual);
    };
}

function testDeploy() {
    return async () => {
        const coinToss = await CoinToss.deployed();

        assert.isNotNull(coinToss);
    };
}

function fundTheContract(accounts) {
    return async () => {
        const coinToss = await CoinToss.deployed();
        const expected = 2e16;

        web3.eth.sendTransaction({ from: accounts[1], to: CoinToss.address, value: expected });

        const actual = await coinToss.bankroll.call();

        assert.equal(actual, expected);
    };
}

// Helper functions
function testResolveBetRequires(betId, accounts, accountNumber, blockToAdvance) {
    return async () => {
        const coinTossMock = await CoinTossMock.deployed();
        const amountToBet = 4e14;

        await coinTossMock.fund({ from: accounts[1], value: 1e15 });
        await coinTossMock.setBetId(betId);
        await coinTossMock.placeBet(userBet, { from: accounts[1], value: amountToBet });
        await advanceToBlock(web3.eth.blockNumber + blockToAdvance);

        await expectThrow(coinTossMock.resolveBet(betId, { from: accounts[accountNumber] }));
    };
}

const testPossibleStates = async (bet, betID, accounts) => {
    const coinTossMock = await CoinTossMock.deployed();
    const initialValueAcc2 = web3.fromWei(web3.eth.getBalance(web3.eth.accounts[2]));
    const numberOfBlocksToAdvance = 6;

    await coinTossMock.fund({ from: accounts[1], value: 25e17 });
    await coinTossMock.setBetId(betID);

    await coinTossMock.placeBet(bet, { from: accounts[2], value: 1e18 });
    await advanceToBlock(web3.eth.blockNumber + numberOfBlocksToAdvance);
    await coinTossMock.resolveBet(betID, { from: accounts[2] });

    const finalBalanceAcc2 = web3.fromWei(web3.eth.getBalance(web3.eth.accounts[2]));

    return (finalBalanceAcc2 - initialValueAcc2);
};
