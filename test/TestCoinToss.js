const CoinToss = artifacts.require('CoinToss');
const { advanceBlock, advanceToBlock } = require('openzeppelin-solidity/test/helpers/advanceToBlock');
const expectThrow = require('./helpers/throwHandler');
const CoinTossMock = artifacts.require('CoinTossMock');
const userBet = false;

contract('testing CoinToss contract', async (accounts) => {
    it('should be deployed to the test chain', testDeploy);
    it('should accept funds for the bankroll through the anonymous function', fundTheContract);
    it('should accept funds for the bankroll through the fund function', fundTheContractThroughFundFunction);
    it('should accept an appropriately sized bet', acceptCorrectBet);
    it('should reject resolveBet call with insufficient blocks passed', rejectResolveBetInsufficientBlocksPassed);
    it('should reject resolveBet call with too many blocks passed', rejectResolveBetTooManyBlocksPassed);
    it('should reject resolveBet call from incorrect address', rejectResolveBetWrongAddress);
    it('should advance the blockchain by a few blocks', advanceAFewBlocks);
    it('should NOT pay out with bet tails, is heads', noPayTailsHeads);
    it('should correctly pay out with bet heads, is heads', payHeadsHeads);
    it('should NOT pay out with bet heads, is tails', noPayHeadsTails);
    it('should correctly pay out with bet tails, is tails', payTailsTails);
    it('should return the same from the constant and the function', returnSameFuncConst);
    it('should not self destruct from non-owner address', noSelfDestructNonOwner);
    it('should reject a bet above the maximumBetSize', rejectTooBigBet);
    it('should reject a bet it cannot afford to pay out', rejectBetBankrollTooSmall);
    it('should selfdestruct', selfDestruct);

    async function selfDestruct() {
        const coinToss = await CoinToss.deployed();

        let noError = false;

        try {
            await coinToss.kill();
            noError = true;
        } catch (err) {
            noError = false;
        }

        assert.isTrue(noError);
    }

    async function rejectResolveBetWrongAddress() {
        await testResolveBetRequires(123, 2, 6);
    }

    async function rejectResolveBetInsufficientBlocksPassed() {
        await testResolveBetRequires(123, 1, 2);
    }

    async function rejectResolveBetTooManyBlocksPassed() {
        await testResolveBetRequires(123, 1, 11);
    }

    async function rejectBetBankrollTooSmall() {
        const coinToss = await CoinToss.deployed();
        const bankroll = await coinToss.bankroll.call();
        const tooBigBet = (parseInt(bankroll) / 2) + 10;
        const placeBet = coinToss.placeBet(userBet, { from: accounts[1], value: tooBigBet });

        await expectThrow(placeBet);
    }

    async function rejectTooBigBet() {
        const coinToss = await CoinToss.deployed();
        const maxBet = await coinToss.maximumBetSize.call();
        const amountToBet = maxBet * 2;
        const placeBet = coinToss.placeBet(userBet, { from: accounts[1], value: amountToBet });

        await expectThrow(placeBet);
    }

    async function noSelfDestructNonOwner() {
        const coinToss = await CoinToss.deployed();

        await expectThrow(coinToss.kill({ from: accounts[2] }));
    }

    async function returnSameFuncConst() {
        const coinToss = await CoinToss.deployed();
        const maxBetFromConst = parseInt(await coinToss.MAXIMUM_PASSED_BLOCKS.call());
        const maxBetFromFunction = parseInt(await coinToss.getMaxPassedBlocks());

        assert.equal(maxBetFromConst, maxBetFromFunction);
    }

    async function payTailsTails() {
        const balanceDifference = await testPossibleStates(false, 1);

        assert(balanceDifference > 0.98);
    }

    async function noPayHeadsTails() {
        const balanceDifference = await testPossibleStates(false, 0);

        assert(balanceDifference < -1);
    }

    async function payHeadsHeads() {
        const balanceDifference = await testPossibleStates(true, 0);

        assert(balanceDifference > 0.98);
    }

    async function noPayTailsHeads() {
        const balanceDifference = await testPossibleStates(true, 1);

        assert(balanceDifference < -1);
    }

    async function fundTheContractThroughFundFunction() {
        const coinToss = await CoinToss.deployed();
        const fundingIncrease = 5e16;
        const currentBalance = await coinToss.bankroll.call();
        const expected = fundingIncrease + parseInt(currentBalance);

        await coinToss.fund({ from: accounts[1], value: fundingIncrease });

        const actual = await coinToss.bankroll.call();

        assert.equal(actual, expected);
    }

    async function acceptCorrectBet() {
        const coinToss = await CoinToss.deployed();
        const amountToBet = 4e14;

        await coinToss.placeBet(userBet, { from: accounts[1], value: amountToBet });
    }

    async function advanceAFewBlocks() {
        const numberOfBlocksToAdvance = 6;
        const initialBlock = web3.eth.getBlock('latest').number;
        const expected = parseInt(initialBlock) + numberOfBlocksToAdvance;

        for (let i = 0; i < numberOfBlocksToAdvance; i++) {
            await advanceBlock();
        }

        const actual = web3.eth.getBlock('latest').number;

        assert.equal(expected, actual);
    }

    async function testDeploy() {
        const coinToss = await CoinToss.deployed();

        assert.isNotNull(coinToss);
    }

    async function fundTheContract() {
        const coinToss = await CoinToss.deployed();
        const expected = 2e16;

        web3.eth.sendTransaction({ from: accounts[1], to: CoinToss.address, value: expected });

        const actual = await coinToss.bankroll.call();

        assert.equal(actual, expected);
    }

    // Helper functions
    async function testResolveBetRequires(betId, accountNumber, blockToAdvance) {
        const coinTossMock = await CoinTossMock.deployed();
        const amountToBet = 4e14;

        await coinTossMock.fund({ from: accounts[1], value: 1e15 });
        await coinTossMock.setBetId(betId);
        await coinTossMock.placeBet(userBet, { from: accounts[1], value: amountToBet });
        await advanceToBlock(web3.eth.blockNumber + blockToAdvance);

        await expectThrow(coinTossMock.resolveBet(betId, { from: accounts[accountNumber] }));
    }

    async function testPossibleStates(bet, betID) {
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
    }
});
