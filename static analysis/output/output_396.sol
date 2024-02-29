pragma solidity ^0.8.9;
interface Oracle {
    function getPrice(address) external view returns (uint, uint);
}

