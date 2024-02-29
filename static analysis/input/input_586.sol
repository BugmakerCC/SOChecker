contract Evolution is IERC721Receiver {
    function change(uint256 gen1tokenId) external {
        EXAMPLE_CONTRACT.safeTransferFrom(msg.sender, address(this), gen1tokenId);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) override external returns (bytes4) {
        return this.onERC721Received.selector;
    }
}


