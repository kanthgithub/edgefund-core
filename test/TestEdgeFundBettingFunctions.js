const EdgeFundBettingFunctions = artifacts.require('EdgeFundBettingFunctions');

contract('testing EdgeFund Contract', async () => {
    it('should be able to get correct multiplier', async () => {
        const edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
        const expected = Math.pow(10, 8);
        const actual = await edgeFundBettingFunctions.getMultiplier.call();

        assert.equal(actual, expected);
    });
});
