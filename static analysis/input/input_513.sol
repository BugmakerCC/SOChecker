interface ERC20 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) internal {}
}

contract ERC1155 {
    ERC20 erc20Contract = ERC20(0x1234...5678);

    function buyNFT(uint256 price)
        external
    {
        erc20Contract.transferFrom(msg.sender, price);

       _mint(msg.sender, tokenId, quantity);
    }

}



