const EdgeFundBettingFunctions = artifacts.require("EdgeFundBettingFunctions")

contract('testing EdgeFund Contract', async (accounts) =>{
    it("should be able to get correct multiplier", async () =>{
        let edgeFundBettingFunctions = await EdgeFundBettingFunctions.deployed();
        let expected = Math.pow(10, 8);
        let actual = await edgeFundBettingFunctions.getMultiplier.call();

        assert.equal(actual, expected);
    });
})
