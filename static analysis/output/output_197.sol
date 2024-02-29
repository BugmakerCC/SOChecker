pragma solidity ^0.8.9;
interface IERC721Receiver {

    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4);
}

contract ERC721_Receiver {
    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
}

