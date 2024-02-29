pragma solidity ^0.8.9;
contract MyContract {
    address payable public owner;
    uint256 public balance;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
        balance += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only owner can withdraw funds"); 
        require(amount <= balance, "Insufficient funds");
        
        balance -= amount;
        owner.transfer(amount);
    }

    fallback() external payable {
        deposit();
    }
}

