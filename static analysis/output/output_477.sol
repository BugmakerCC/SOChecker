pragma solidity ^0.8;

contract Caller {
    event IsContract();
    event NotContract();

    constructor(Target target) {
        if (target.isCallerContract()) {
            emit IsContract();
        } else {
            emit NotContract();
        }
    }
}

contract Target {
    function isCallerContract() external view returns (bool) {
        return msg.sender.code.length != 0;
    }
}

