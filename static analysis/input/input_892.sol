pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyCollection is ERC721, Ownable {

    constructor() ERC721("MyCollection", "MyC") {
        _mint(owner(), 1);
    }

    function claim() external {
        require(ownerOf(1) == owner(), "Already claimed");
        _transfer(owner(), msg.sender, 1);
    }
}


