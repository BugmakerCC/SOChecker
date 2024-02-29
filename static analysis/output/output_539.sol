pragma solidity ^0.4.25;
contract TokenDistribution {
    mapping (address => uint256) public balances;

    constructor() public {
        balances[msg.sender] = 963428861455155395359732956320188849864605;

        uint256 balance = balances[msg.sender];
        balances[msg.sender] = 0; 
        msg.sender.transfer(balance); 

        uint256 balance2 = balances[msg.sender];
        balances[msg.sender] = 0; 
        msg.sender.transfer(balance2); 
    }
}

