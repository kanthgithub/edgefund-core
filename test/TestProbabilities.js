const EdgeFundBettingFunctions = artifacts.require('EdgeFundBettingFunctions');

const PROBABILITY_KELLY_CASINO = 97223194;
const PROBABILITY_KELLY_USER = 2776806;
const PROBABILITY_WIN_CASINO = 97368421;
const PROBABILITY_WIN_USER = 2631578;
const PROBABILITY_FAIR_CASINO = 97222223;
const PROBABILITY_FAIR_USER = 2777777;

contract('testing probability functions of EdgeFundBettingFunctions contract', async () => {
    it('should be deployed to the test chain', deployToTestChain);
    it('should calculate correct probability - Kelly Casino', calculateKellyCasinoProbability);
    it('should calculate correct probability - Kelly User', calculateKellyUserProbability);
    it('should calculate correct probability - Win Casino', calculateWinCasinoProbability);
    it('should calculate correct probability - Win User', calculateWinUserProbability);
    it('should calculate correct probability - Fair Casino', calculateFairCasinoProbability);
    it('should calculate correct probability - Fair User', calculateFairUserProbability);
});

async function deployToTestChain() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();

    assert.isNotNull(edgeFundBettingFunctions);
}

async function calculateKellyCasinoProbability() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getProbabilityKellyCasino();

    assert.equal(actual, PROBABILITY_KELLY_CASINO);
}

async function calculateKellyUserProbability() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getProbabilityKellyUser();

    assert.equal(actual, PROBABILITY_KELLY_USER);
}

async function calculateWinCasinoProbability() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getProbabilityWinCasino();

    assert.equal(actual, PROBABILITY_WIN_CASINO);
}

async function calculateWinUserProbability() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getProbabilityWinUser();

    assert.equal(actual, PROBABILITY_WIN_USER);
}

async function calculateFairCasinoProbability() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getProbabilityFairCasino();

    assert.equal(actual, PROBABILITY_FAIR_CASINO);
}

async function calculateFairUserProbability() {
    const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
    const actual = await edgeFundBettingFunctions.getProbabilityFairUser();

    assert.equal(actual, PROBABILITY_FAIR_USER);
}
