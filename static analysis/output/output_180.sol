pragma solidity ^0.8.9;
library UIntFunctions {
    function isEven(uint _participants) internal view returns (bool) {
        return _participants % 2 == 0;
    }
}

contract Game {
    using UIntFunctions for uint;
    uint public participants;
    bool public allowTeams;

    constructor(uint _participants) {
        participants = _participants;
        allowTeams = _participants.isEven();
    }

    function isEven(uint _participants) public returns(bool) {
        if (_participants.isEven()) {
            return allowTeams = true;
        }
        else return allowTeams;
    }
}

