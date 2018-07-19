const helper = require("./helpers/delorean");

describe("Testing Helper Functions", () => {
    it("should advance the blockchain forward a block", async () =>{
        const originalBlockHash = web3.eth.getBlock('latest').hash;
        let newBlockHash = web3.eth.getBlock('latest').hash;

        newBlockHash = await helper.advanceBlock();

        assert.notEqual(originalBlockHash, newBlockHash);
    });
});
