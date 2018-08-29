const CoinTossMock = artifacts.require('CoinTossMock');

contract('testing CoinTossMock contract', async (accounts) => {
    it('should be deployed to the test chain', async () => {
        const coinTossMock = await CoinTossMock.deployed();

        assert.isNotNull(coinTossMock);
    });

    it('should be possible to mock a true / winning result', async () => {
        const coinTossMock = await CoinTossMock.deployed();

        let mockedResult = false;

        // Pass in an even betID to return a winning bet
        mockedResult = await coinTossMock.getResultForBet(0, 0);

        assert.isTrue(mockedResult);
    });

    it('should be possible to mock a false / losing result', async () => {
        const coinTossMock = await CoinTossMock.deployed();

        let mockedResult = true;

        // Pass in an odd betID to return a losing bet
        mockedResult = await coinTossMock.getResultForBet(1, 0);

        assert.isNotTrue(mockedResult);
    });

    it('should be possible to force the bet ID to a value', async () => {
        const coinTossMock = await CoinTossMock.deployed();
        const expected = 123;

        await coinTossMock.setBetId(expected);
        const actual = await coinTossMock.counter();

        assert.equal(actual, expected);
    });
});
