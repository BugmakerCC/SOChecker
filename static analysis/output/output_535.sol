pragma solidity ^0.8.9;
interface Owners {
    function addKhatianFromOld(uint64 _khatianiId, bytes32 _plotHash, uint16 _percentOwn, bytes32 _buyFrom, uint[] memory _user, uint16[] memory _percentage) external returns (bool);
}

