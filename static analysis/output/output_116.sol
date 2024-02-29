pragma solidity ^0.4.25;
contract Ownable { function owner() public constant returns (address _owner); 
    function transferOwnership(address _new_owner) public; 
}

contract MyToken { 
    string public name = "MyToken";
    string public symbol = "MTV";
    uint8 public decimal_places = 18;
    uint256 public total_supply = 600000000000000000000000000;
    address public i_owner;
    constructor() {
        i_owner = msg.sender; 
    }
}

