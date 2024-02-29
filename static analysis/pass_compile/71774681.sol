pragma solidity ^0.4.24;

contract balance {
    address owner;
    mapping(address => uint256) public balances;

    constructor() public {
        //  If you declare variables - initialize them
        owner = msg.sender;
    }

    //  Returns only if called from another function
    function balanceIncrement(address _address) public returns (uint256){
        //  If you initialize owner - check it
        require(owner == msg.sender, "Only owner can increment balances");
        return balances[_address]++;
    }

    //  Returns without modifying chain
    function balanceViewIncrement(address _address) public view returns (uint256 value){
        value = balances[_address];
        value++;
    }
}

