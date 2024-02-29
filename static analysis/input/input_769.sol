pragma solidity >= 0.7.0 <0.9.0;

contract Challenge0 {
    address public owner;
    uint256 userBalance;
    uint256 withdrawAmountVariable;
    bool public canWithdraw = false;
  
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You aren't the smart contact's owner");
        _;
    }

    function getBalance() public returns(uint) {
    }

    function withdrawAmount(uint256 amount) onlyOwner payable public {
        require(msg.value == amount);
        require(amount <= getBalance());
        payable(msg.sender).transfer(amount);
    }

    function setUserBalance()external view {
    }
    
    function getUserBalance()public view returns (uint256){
        return address(this).balance;
    }

}


