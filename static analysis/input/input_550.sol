pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract MyCollection is ERC721Enumerable, ERC721Burnable {
    constructor() ERC721("CollectionName", "Symbol") {
        _mint(msg.sender, 1);
        _burn(1);
        _mint(msg.sender, 2);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
        return ERC721Enumerable._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return ERC721Enumerable.supportsInterface(interfaceId);
    }
}

pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract MyCollection is ERC721Enumerable, ERC721Burnable {
    uint256 public mintCounter;

    constructor() ERC721("CollectionName", "Symbol") {
        _mint(msg.sender, 1);
        _burn(1);
        _mint(msg.sender, 2);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
        if (from == address(0)) {
            mintCounter++;
        }

        return ERC721Enumerable._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return ERC721Enumerable.supportsInterface(interfaceId);
    }
}


