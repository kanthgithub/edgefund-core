const EdgeFundPOC = artifacts.require("EdgeFundPOC")

contract('testing EdgeFund Contract', async (accounts) =>{

    it("should be able to get correct multiplier", async () =>{
        let edgeFundPOC = await EdgeFundPOC.deployed();
        let expected = Math.pow(10, 8);
        let actual = await edgeFundPOC.getMultiplier.call();

        assert.equal(actual, expected);
    });

    // test the eval_mine function
    it("should advance the blockchain forward a block", async () =>{
        let initialBlock = 0 // get blockhash

        web3.currentProvider.sendAsync({
            jsonrpc: "2.0",
            method: "evm_mine",
            id: 12345
          }, function(err, result) {
            // this is your callback
          });

          let finalBlock = 1 // get blockhas

          assert.notEqual(initialBlock, finalBlock);
    });
})
