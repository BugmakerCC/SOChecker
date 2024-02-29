pragma solidity >= 0.7.0 < 0.9.0;

contract receiverContract {

    event Log(uint);
    address public recipient;

    constructor () {
        recipient = address(this);
    } 

    fallback () external payable {
        emit Log(gasleft());
    } 

    receive () external payable {}

    function getThisAddress() public view returns(address) {
        return address(this);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}



contract senderContract is receiverContract {

    address _recipient=super.getThisAddress();


    function manualTransfer (address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function autoTransfer () public payable {
        payable(_recipient).transfer(msg.value);
    }

}


