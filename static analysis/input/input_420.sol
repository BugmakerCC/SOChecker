contract MultiToken is ERC1155 {
    constructor(string memory uri) ERC1155(uri) payable {}
}

multiToken = await factory.deploy(uri, {
    value: ethers.utils.parseUnits("1"), 
});


