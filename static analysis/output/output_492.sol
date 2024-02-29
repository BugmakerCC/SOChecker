pragma solidity ^0.8.9;
interface Ownable {
    function owner() external view returns (address);

    
    function renounce() external;
}

