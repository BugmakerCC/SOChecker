//SPDX-License-Identifier: GPL-3.0
 
pragma solidity >= 0.6.0 < 0.9.0;
 
contract Sample{
    
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    receive() external payable { 
    }
    
    fallback() external payable {
    }
    
    function getBalance() public view returns (uint){
        return address(this).balance;
    }

    // this function is for sending the wei/ether OUT from this smart contract (address) to another contract/external account.
    function transferEther(address payable recipient, uint amount) public returns(bool){
        require(owner == msg.sender, "transfer failed because you are not the owner."); // 
        if (amount <= getBalance()) {
            recipient.transfer(amount);
            return true;
        } else {
            return false;
        }
    }
}

