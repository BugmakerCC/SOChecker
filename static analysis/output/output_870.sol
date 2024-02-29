pragma solidity ^0.8.9;
interface IMyUni {
    function myUni(address) external view returns (address);
}

interface IUniverse {
    function getUniverseArray(address _address) external view returns (uint64[3] memory);
}

