pragma solidity ^0.8.9;
interface StandardToken {
    function getFreezing() external view returns (uint amount);
}

