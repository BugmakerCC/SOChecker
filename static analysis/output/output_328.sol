pragma solidity ^0.7.6;
contract FundWithdrawal {
    address owner;
    address payable public ownerAddress;

    constructor() public {
        ownerAddress = msg.sender;
        owner = msg.sender;
    }

    function withdrawFunds() public {
        require(msg.sender == owner, "Only the owner can withdraw funds.");
        payable(msg.sender).transfer(address(this).balance);
    }
}

