pragma solidity ^0.4.20;
interface IReverseLookup {
    function getNames(address[] memory) public view returns (string[] memory);
}

