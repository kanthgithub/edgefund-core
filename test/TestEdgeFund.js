const EdgeFund = artifacts.require('EdgeFund');

contract('tests EV functions of EdgeFund contract', async () => {
    it('should be deployed to the test chain', deployToTestChain);
    it('should have a starting bankroll of 1000000', testInitialBankroll);
    it('should have a temp function which returns 97223194', testTempFunction);
});

async function deployToTestChain() {
    const edgeFund = await EdgeFund.deployed();

    assert.isNotNull(edgeFund);
}

async function testInitialBankroll() {
    const edgeFund = await EdgeFund.deployed();
    const expected = 10000000 * Math.pow(10, 8);
    const actual = await edgeFund.getBankrollBalance();

    assert.equal(expected, actual);
}

async function testTempFunction() {
    const edgeFund = await EdgeFund.deployed();
    const expected = 97223194;
    const actual = await edgeFund.Temp();

    assert.equal(expected, actual);
}
