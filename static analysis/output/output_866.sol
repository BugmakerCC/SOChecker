pragma solidity ^0.8.9;
contract Owned {
    address payable private owner;

    
    constructor() {
        owner = payable(msg.sender);
    }
    
    modifier onlyOwner() {
        require(
            owner == msg.sender,
            ' Owned: Caller is not the owner'
        );
        _;
    }
    
    function transferOwnership(address new_owner) public onlyOwner {
        require(new_owner != address(0), ' Owned: new owner is the zero address');
        owner = payable(new_owner);
    }
}

