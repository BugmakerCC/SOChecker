 //SPDX-License-Identifier: UNLICENSED

pragma solidity 0.6.12;


contract NFT {

    //Ensure that only the owner can call important functions
    address owner; 
    

    constructor() public {
        owner = msg.sender;
    }

    mapping (address => bool) public _onlyIfMarketplace;

    function mint() public {
        require(owner == msg.sender);
    }

    function transfer() public {

    }


    function shuffle() public {
        require(_onlyIfMarketplace[msg.sender] == true);
    }

    //You can always add an address that can call this function, 
    //and you can also write another one to remove the address which can call this function
    function setMarketplaceContract(address MarketplaceContract) public {
        require(owner == msg.sender);
        _onlyIfMarketplace[MarketplaceContract] = true;
    }
}


contract Marketplace {

    //Call NFT contract
    NFT nftContract; 

     //Ensure that only the owner can call important functions
    address owner; 
   

    constructor(address nftAddress) public {
        owner = msg.sender;
        nftContract = NFT(nftAddress);
    }

    // You can change the NFT contract you want to call at any time
    function changeNFTAddress(address newNFTAddress) public {
        require(owner == msg.sender);
        nftContract = NFT(newNFTAddress);
    }

    //Call the function of NFT contract
    function buy() public {
        nftContract.transfer();
        nftContract.shuffle();
    }

}

