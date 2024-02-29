simpleStorageArray.push(simpleStorage2);

pragma solidity ^0.6.0;

import "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;
    SimpleStorage public simpleStorage2 = new SimpleStorage();

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
        simpleStorageArray.push(simpleStorage2);
    }
}


