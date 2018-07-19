timeTravel = (time) => {
    return new Promise((resolve, reject) => {
        web3.currentProvider.sendAsync({
            jsonrpc: "2.0",
            method: "evm_increaseTime",
            params: [time],
            id: new Date().getTime()
        }, (err, result) => {
            if (err) { return reject(err); }

            return resolve(result)
        });
    });
}

advanceBlock = () => {
    return new Promise((resolve, reject) => {
        web3.currentProvider.sendAsync({
            jsonrpc: "2.0",
            method: "evm_mine",
            id: new Date().getTime()
        }, (err, result) => {
            const newBlockHash = web3.eth.getBlock('latest').hash;

            if (err) { return reject(err); }

            return resolve(newBlockHash)
        });
    });
}

module.exports = {
    timeTravel,
    advanceBlock
}
