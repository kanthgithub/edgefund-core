const advanceTimeAndBlock = async (time) => {
    await advanceTime(time);
    await advanceBlock();

    return Promise.resolve(web3.eth.getBlock('latest'));
};

const advanceMultipleBlocks = async (numberOfBlocksToAdvance) => {
    const promises = [];

    for (let i = 0; i < numberOfBlocksToAdvance; i++) {
        promises.push(advanceBlock());
    }

    Promise.all(promises).then(() => {
        return Promise.resolve(web3.eth.getBlock('latest'));
    });
};

const advanceTime = (time) => {
    return new Promise((resolve, reject) => {
        web3.currentProvider.sendAsync({
            jsonrpc: '2.0',
            method: 'evm_increaseTime',
            params: [time],
            id: new Date().getTime()
        }, (err, result) => {
            if (err) { return reject(err); }

            return resolve(result);
        });
    });
};

const advanceBlock = () => {
    return new Promise((resolve, reject) => {
        web3.currentProvider.sendAsync({
            jsonrpc: '2.0',
            method: 'evm_mine',
            id: new Date().getTime()
        }, (err, result) => {
            if (err) { return reject(err); }

            const newBlockHash = web3.eth.getBlock('latest').hash;

            return resolve(newBlockHash);
        });
    });
};

module.exports = {
    advanceTime,
    advanceBlock,
    advanceTimeAndBlock,
    advanceMultipleBlocks
};
