import "./UIntFunctions.sol";

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


