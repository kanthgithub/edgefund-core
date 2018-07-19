const EdgeFundPOC = artifacts.require("EdgeFundPOC")

contract('testing EdgeFund Contract', async (accounts) =>{

    it("should be able to get correct multiplier", async () =>{
        let edgeFundPOC = await EdgeFundPOC.deployed();
        let expected = Math.pow(10, 8);
        let actual = await edgeFundPOC.getMultiplier.call();

        assert.equal(actual, expected);
    });

    // test the eval_mine function
    it("should advance the blockchain forward a block", (done) =>{
        const originalBlockHash = web3.eth.getBlock('latest').hash;
        let newBlockHash = web3.eth.getBlock('latest').hash;;

        web3.currentProvider.sendAsync({
            jsonrpc: "2.0",
            method: "evm_mine",
            id: 12345
            }, (error, result) => {
                newBlockHash = web3.eth.getBlock('latest').hash;
                (newBlockHash != originalBlockHash) ? done() : done(new Error("Block not mined"));
            });
    });
})
