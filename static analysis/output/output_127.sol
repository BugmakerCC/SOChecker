pragma solidity ^0.8.9;
contract NFTContract {
    // Mapping to store minted addresses
    mapping(uint => address) public getMintedAddress;
    uint public indexForSenders;

    constructor() public {
        indexForSenders = 0;
    }

    // Function to create an NFT
    function createNFT() public returns(bytes32) {
        getMintedAddress[indexForSenders]=msg.sender;
        indexForSenders += 1;
        
        // Assuming the NFT is a hash of the sender and the index
        bytes32 NFT = keccak256(abi.encodePacked(msg.sender, indexForSenders));
        
        return NFT;
    }
}

