pragma solidity ^0.8.9;
interface INft {
    function ownerOf(uint256 tokenId) external view returns (address);
}

contract MyContract {
    function getNftTokenHolder(address _nft, uint _tokenIds) public view returns (address[] memory) {
        address[] memory addr = new address[](_tokenIds);
        for (uint i; i < _tokenIds; i++) {
            addr[i] = INft(_nft).ownerOf(i);
        }
        return addr;
    }
}

