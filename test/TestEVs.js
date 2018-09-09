const EdgeFundBettingFunctions = artifacts.require('EdgeFundBettingFunctions');

const EV_KELLY_CASINO = 3500000;
const EV_KELLY_USER = 3500000;
const EV_TOTAL_CASINO = 526315790;
const EV_TOTAL_USER = 526315789;
const EV_GAME_OPERATOR_CASINO = 522815790;
const EV_GAME_OPERATOR_USER = 522815789;

contract('tests EV functions of EdgeFundBettingFunctions contract', async () => {
    it('should be deployed to the test chain', deployToTestChain);
    it('should calculate correct EV - Kelly Casino', testEVKellyCasino);
    it('should calculate correct EV - Kelly User', testEVKellyUser);
    it('should calculate correct EV - Total Casino', testEVTotalCasino);
    it('should calculate correct EV - Total User', testEVTotalUser);
    it('should calculate correct EV - GameOperator Casino', testEVGameOpCasino);
    it('should calculate correct EV - GameOperator User', testEVGameOpUser);
});

async function deployToTestChain() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();

    assert.isNotNull(edgeFundBettingFunctions);
}

async function testEVKellyCasino() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEVKellyCasino();

    assert.equal(actual, EV_KELLY_CASINO);
}

async function testEVKellyUser() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEVKellyUser();

    assert.equal(actual, EV_KELLY_USER);
}

async function testEVTotalCasino() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEVTotalCasino();

    assert.equal(actual, EV_TOTAL_CASINO);
}

async function testEVTotalUser() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEVTotalUser();

    assert.equal(actual, EV_TOTAL_USER);
}

async function testEVGameOpCasino() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEVGameOperatorCasino();

    assert.equal(actual, EV_GAME_OPERATOR_CASINO);
}

async function testEVGameOpUser() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEVGameOperatorUser();

    assert.equal(actual, EV_GAME_OPERATOR_USER);
}
