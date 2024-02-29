contract A {
    uint256 arrSize;
    constructor(uint256 _size){
        arrSize = _size;
    }

    function giveMeAnArray() public pure returns (uint256[]){
        uint256[arrSize] memory arr; 
        uint256[] memory arr = new uint256[](arrSize); 
    }
}


