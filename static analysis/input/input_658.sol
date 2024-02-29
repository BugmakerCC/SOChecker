address payable contractAddress = payable(address(this));
contractAddress.transfer(nftCost);

contract MyContract {
    receive() external payable {
    }
}

const tx = await this.nft.connect(this.normalUser).safeMintNft({
    value: ethers.utils.parseEther("0.1")
});

function safeMintNft() public payable whenNotPaused {
    require(msg.value == nftCost);
}


