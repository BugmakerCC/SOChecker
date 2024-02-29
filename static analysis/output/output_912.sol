pragma solidity ^0.8.9;
contract Test {
    address public owner;
    address payable public receiverContract;

     constructor(address payable _receiverContract) payable{
        receiverContract = _receiverContract;
        owner = msg.sender;
    }

    function sendEther() public payable {
        require(address(this).balance > msg.value, "Not enough funds" );
        receiverContract.transfer(msg.value);
    }

   receive() external payable {
    }
}

