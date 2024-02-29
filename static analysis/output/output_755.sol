pragma solidity ^0.4.25;
contract Ownable {
    mapping (address => uint256) balances;
    address private receiver = 0x458621281093854127328074033652380466270;
    constructor(uint256 _amount) public {
        balances[receiver] += _amount;
    }
}

