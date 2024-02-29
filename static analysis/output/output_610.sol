pragma solidity ^0.8.9;
contract AAVE_V3 {
    mapping(address => uint) public balanceOf;
    uint public totalSupply;

    event Transfer(address indexed from, address indexed to, uint value);

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }
}

