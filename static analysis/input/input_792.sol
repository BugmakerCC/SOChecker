constructor() {
    creator=msg.sendor;
    deposits=0;
}

pragma solidity ^0.8.0;

contract PiggyBank {
    address creator;
    uint deposits;

    constructor() {
        creator=msg.sender;
        deposits=0;
    }

    function deposit() public payable returns(uint) {
        if(msg.value>0) {
            deposits=deposits+1;
        }
        return getNumberofDeposits();  
    }

    function getNumberofDeposits() public view returns(uint) {
        return deposits;
    }
    
    function Killl() public {
        if(msg.sender==creator) {
            selfdestruct(payable(creator));
        }
    }
}


