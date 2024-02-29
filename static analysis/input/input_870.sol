function getUniverseArray(address _address) public view returns (uint64[3] memory) {
    return myUni[_address].space;
}


