pragma solidity ^0.8.9;
contract ERC721Receiver {
    
    function onERC721received(address, address _from, uint256 _tokenID) public returns (bytes4) {}
}

