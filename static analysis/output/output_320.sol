pragma solidity ^0.8.9;
contract FakeToken {
    
    mapping(address => uint256) public balanceOf;

    uint256 public totalSupply;

    constructor(uint256 _initialSupply) payable {
            balanceOf[msg.sender] = _initialSupply;
            totalSupply = _initialSupply;
    }
    
}

