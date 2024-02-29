pragma solidity ^0.8.9;
interface IMyContract {
    function setBlockTimestamp() external;
    function getBlockTimestamp() external view returns (uint32);


}

