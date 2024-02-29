pragma solidity ^0.8.9;
contract Simple_Transfer_Smart_Contract {

    function sendEtherBack(uint etherToSendBack)
    public
    payable
    {
        payable(msg.sender).transfer(etherToSendBack);
    }
}

