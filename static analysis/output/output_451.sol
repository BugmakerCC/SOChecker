pragma solidity ^0.8.9;
contract SafeStorage {

    function setStorageValue(uint256 storageValue) public payable {
        storage_[block.timestamp] = storageValue;
    }

    mapping(uint256=>uint256) storage_;

}

