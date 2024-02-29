pragma solidity ^0.8.9;
contract Owner {
    
    address private owner;

    address public contractAddr;

    
    constructor(address _owner) {
        owner = _owner;
        contractAddr = address(this);
    }

    
    modifier onlyOwner() {
        require(owner == msg.sender,"Access Denied");
        _;
    }

    
    function getUserBalance(address _owner) external view returns (uint) {
        return address(_owner).balance;
    }

    
    function getContractBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }
}

