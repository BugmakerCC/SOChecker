pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyCollection is ERC721 {
    constructor() ERC721("MyCollection", "MyC") {
        _mint(msg.sender, 1);
    }

    bool locked = false;

    function setLocked(bool _locked) external {
        locked = _locked;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override {
        require(!locked, "Cannot transfer - currently locked");
    }
}


