it('Should correctly set totalSupply to: 1T', async () => {
    const totalSupply = await hardhatToken.totalSupply();
    const decimals = ethers.BigNumber.from(10).pow(9);

    expect(totalSupply).to.equal(
        ethers.BigNumber.from(1_000_000_000_000).mul(decimals)
    );
});


