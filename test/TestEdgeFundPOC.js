const helper = require("./helpers/delorean");
const EdgeFundPOC = artifacts.require("EdgeFundPOC")

contract('testing EdgeFund Contract', async (accounts) =>{

    it("should be able to get correct multiplier", async () =>{
        let edgeFundPOC = await EdgeFundPOC.deployed();
        let expected = Math.pow(10, 8);
        let actual = await edgeFundPOC.getMultiplier.call();

        assert.equal(actual, expected);
    });

    it("should advance the blockchain forward a block", async () =>{
        const originalBlockHash = web3.eth.getBlock('latest').hash;
        let newBlockHash = web3.eth.getBlock('latest').hash;

        newBlockHash = await helper.advanceBlock();

        assert.notEqual(originalBlockHash, newBlockHash);
    });
})
