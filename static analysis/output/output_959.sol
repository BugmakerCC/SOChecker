pragma solidity ^0.7.6;
contract NFT {
    uint public nftLimit;
    
    constructor() {
        nftLimit = 2;
    }

    function mint(uint amount) public {
        require(amount >= 1, 'need to mint at least 1 NFT');
        require(amount <= nftLimit, 'max mint amount per session exceeded');
        require(amount >= 1, 'need to mint at least 1 NFT');
        address payable nftAccount = msg.sender;
        for (uint256 i = 0; i < amount; i++) {
            nftAccount.transfer(10);
        }
    }
}

