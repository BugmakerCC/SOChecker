pragma solidity ^0.8.9;
interface IMoneyToken {
    function transfer(address to, uint256 value) external returns (bool);
}

