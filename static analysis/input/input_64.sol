
pragma solidity 0.6.12;


contract NFT {

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

    function setMarketplaceContract(address MarketplaceContract) public {
        require(owner == msg.sender);
        _onlyIfMarketplace[MarketplaceContract] = true;
    }
}


contract Marketplace {

    NFT nftContract; 

    address owner; 
   

    constructor(address nftAddress) public {
        owner = msg.sender;
        nftContract = NFT(nftAddress);
    }

    function changeNFTAddress(address newNFTAddress) public {
        require(owner == msg.sender);
        nftContract = NFT(newNFTAddress);
    }

    function buy() public {
        nftContract.transfer();
        nftContract.shuffle();
    }

}


