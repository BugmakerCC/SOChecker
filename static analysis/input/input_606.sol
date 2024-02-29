  function printAddresses() public returns(addrToValue[] memory){
        addrToValue[] memory addressesArray = new addrToValue[](simpleStorageArray.length);    
        for(uint256 _ssArrIndex=0; _ssArrIndex<simpleStorageArray.length; _ssArrIndex++){
            addrToValue memory addressTov;
            addressTov.addr = address(simpleStorageArray[_ssArrIndex]);
            addressTov.value = SimpleStorage(address(simpleStorageArray[_ssArrIndex])).retrieve();
            addressesArray[_ssArrIndex] = addressTov;
        }
        return addressesArray;
    }


