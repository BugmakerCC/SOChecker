pragma solidity ^0.8.9;
interface Ownable {
    function transferOwnership(address newOwner) external;
}

interface ERC20 {
    function transfer(address to, uint value) external returns (bool);
}

