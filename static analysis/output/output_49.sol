pragma solidity ^0.8.9;
contract Puis {
    mapping(address => uint256) private balanceOf;
    event Transfer(address indexed from, address indexed to, uint256 value);
    function transfer(address to, uint256 value) public {
        require(balanceOf[msg.sender] >= value, 'The account has low funds');
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
    }
}

