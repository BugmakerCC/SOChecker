it('mint amount', async function () {
    try {
        await NFT.mint.sendTransaction(0);
    }
    catch (err) {
        assert.equal("need to mint at least 1 NFT", err.reason);
    }
});

it('mint amount2', async function () {
    try {
        await NFT.mint.sendTransaction(1);
    }
    catch (err) {
        assert.equal("max mint amount per session exceeded", err.reason);
    }
});

it('mint amount3', async function () {
    try {
        await NFT.mint.sendTransaction(2);
    }
    catch (err) {
        assert.equal("max NFT limit exceeded", err.reason);
    }
});


