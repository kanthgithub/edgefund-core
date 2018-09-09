const CoinTossMock = artifacts.require('CoinTossMock');

contract('testing CoinTossMock contract', async (accounts) => {
    it('should be deployed to the test chain', testDeploy);
    it('should be possible to mock a true / winning result', testMockWinningResult);
    it('should be possible to mock a false / losing result', testMockLosingResult);
    it('should be possible to force the bet ID to a value', testMockBetId);
});

async function testDeploy() {
    const coinTossMock = await CoinTossMock.deployed();

    assert.isNotNull(coinTossMock);
}

async function testMockWinningResult() {
    const coinTossMock = await CoinTossMock.deployed();

    let mockedResult = false;

    // Pass in an even betID to return a winning bet
    mockedResult = await coinTossMock.getResultForBet(0, 0);

    assert.isTrue(mockedResult);
}

async function testMockLosingResult() {
    const coinTossMock = await CoinTossMock.deployed();

    let mockedResult = true;

    // Pass in an odd betID to return a losing bet
    mockedResult = await coinTossMock.getResultForBet(1, 0);

    assert.isNotTrue(mockedResult);
}

async function testMockBetId() {
    const coinTossMock = await CoinTossMock.deployed();
    const expected = 123;

    await coinTossMock.setBetId(expected);
    const actual = await coinTossMock.counter();

    assert.equal(actual, expected);
}
