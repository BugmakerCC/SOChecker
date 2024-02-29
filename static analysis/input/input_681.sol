pragma solidity ^0.4.24;

contract balance {
    address owner;
    mapping(address => uint256) public balances;

    constructor() public {
        owner = msg.sender;
    }

    function balanceIncrement(address _address) public returns (uint256){
        require(owner == msg.sender, "Only owner can increment balances");
        return balances[_address]++;
    }

    function balanceViewIncrement(address _address) public view returns (uint256 value){
        value = balances[_address];
        value++;
    }
}


