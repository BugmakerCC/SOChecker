pragma solidity ^0.5.13;

contract TransferMoney {  
    uint public receivedBalance;

    function ReceiveMoney() public payable{
        receivedBalance += msg.value;
    }

    function ShowContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function ShowContractBalance(address payable toAccount, uint amount) public{
        toAccount.transfer(amount);
    }
}


