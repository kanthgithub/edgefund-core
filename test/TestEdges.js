const EdgeFundBettingFunctions = artifacts.require('EdgeFundBettingFunctions');

const EDGE_KELLY_CASINO = 1000;
const EDGE_KELLY_USER = 35000;
const EDGE_TOTAL_CASINO = 150375;
const EDGE_TOTAL_USER = 5263158;
const EDGE_GAME_OPERATOR_CASINO = 149375;
const EDGE_GAME_OPERATOR_USER = 5228158;

contract('tests Edge functions of EdgeFundBettingFunctions contract', async () => {
    it('should be deployed to the test chain', deployToTestChain);
    it('should get correct Edge - Kelly Casino', testEdgeKellyCasino);
    it('should get correct Edge - Kelly User', testEdgeKellyUser);
    it('should get correct Edge - Total Casino', testEdgeTotalCasino);
    it('should get correct Edge - Total User', testEdgeTotalUser);
    it('should get correct Edge - GameOperator Casino', testEdgeGameOpCasino);
    it('should get correct Edge - GameOperator User', testEdgeGameOpUser);
});

async function deployToTestChain() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();

    assert.isNotNull(edgeFundBettingFunctions);
}

async function testEdgeKellyCasino() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEdgeKellyCasino();

    assert.equal(actual, EDGE_KELLY_CASINO);
}

async function testEdgeKellyUser() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEdgeKellyUser();

    assert.equal(actual, EDGE_KELLY_USER);
}

async function testEdgeTotalCasino() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEdgeTotalCasino();

    assert.equal(actual, EDGE_TOTAL_CASINO);
}

async function testEdgeTotalUser() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEdgeTotalUser();

    assert.equal(actual, EDGE_TOTAL_USER);
}

async function testEdgeGameOpCasino() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEdgeGameOperatorCasino();

    assert.equal(actual, EDGE_GAME_OPERATOR_CASINO);
}

async function testEdgeGameOpUser() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getEdgeGameOperatorUser();

    assert.equal(actual, EDGE_GAME_OPERATOR_USER);
}
