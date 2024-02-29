function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
    SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
    simpleStorage.store(_simpleStorageNumber);
} 
} 

function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
  SimpleStorage simpleStorage = 
  SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
  simpleStorage.store(_simpleStorageNumber);
}


