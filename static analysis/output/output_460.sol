pragma solidity ^0.8.9;
interface IERC20 {
    function allowance(address owner, address spender) external view returns (uint256);
    function balanceOf(address owner) external view returns (uint256 balance);
    function transfer(address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IChild {
    function childOf(address parent) external view returns (bool);
}

interface IAgent {
    function getChild(address parent, address child) external view returns (bool);
}

