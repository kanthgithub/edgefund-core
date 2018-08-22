const EdgeFund = artifacts.require('EdgeFund');

contract('testing EdgeFund contract', async (accounts) => {
    it('should be deployed to the test chain', async () => {
        const edgeFund = await EdgeFund.deployed();

        assert.isNotNull(edgeFund);
    });

    it('should be correctly display the starting balance', async () => {
        const edgeFund = await EdgeFund.deployed();
        const multiplier = 100000000;
        const expected = 10000000 * multiplier;
        const actual =  await edgeFund.getBankrollBalance.call();

        assert.equal(actual, expected);
    });
});
