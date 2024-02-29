it("Should emit a received NFT event", async function () {
      const { bridge, owner } = await loadFixture(deployFixture);
      const { token } = await loadFixture(deployMockNFTFixture);

      await token.mint(owner.address)
      console.log(await token.balanceOf(owner.address));
      console.log(await token.ownerOf(1));

      console.log("bridge.target: ", bridge.target)
      console.log("owner.address: ", owner.address)

      await token.approve(bridge.target, 1)

      
      console.log(await token.balanceOf(bridge.target));
      console.log(await token.ownerOf(1));

      expect(await token.transferFrom(owner.address, bridge.target, 1)) 
      .to.emit(bridge, "ReceivedNFT");
    })


