const EdgeFundBettingFunctions = artifacts.require('EdgeFundBettingFunctions');

contract('testing EdgeFund Contract', async () => {
    it('should be able to get correct multiplier', testMultiplier);
    it('should have an initial bankroll of 1000000000000000', testBankroll);
    it('should have casino decimal payout odds of 102857142', testCasinoDecimalPayoutOdds);
    it('should have a casino liability of 350000000000', testCasinoLiability);
    it('should have an FStar value of 35000', testFStarValue);
    it('should have a Kelly Edge of 1000', testKellyEdge);
});

async function testMultiplier() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const expected = Math.pow(10, 8);
    const actual = await edgeFundBettingFunctions.getMultiplier();

    assert.equal(actual, expected);
}

async function testBankroll() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const expected = 1000000000000000;
    const bankroll = await edgeFundBettingFunctions.getBankRoll();
    const actual = parseInt(bankroll);

    assert.equal(expected, actual);
}

async function testCasinoDecimalPayoutOdds() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const expected = 102857142;

    const actual = await edgeFundBettingFunctions.getCasinoDecimalPayoutOdds();

    assert.equal(actual, expected);
}

async function testCasinoLiability() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const expected = 350000000000;
    const actual = await edgeFundBettingFunctions.getCasinoLiability();

    assert.equal(expected, actual);
}

async function testFStarValue() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const expected = 35000;
    const actual = await edgeFundBettingFunctions.getFStar();

    assert.equal(expected, actual);
}

async function testKellyEdge() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const expected = 1000;
    const actual = await edgeFundBettingFunctions.getKellyEdge();

    assert.equal(expected, actual);
}
