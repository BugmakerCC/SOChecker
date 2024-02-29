pragma solidity ^0.8.9;
contract A {
    uint256 public arrSize;
    
    constructor(uint256 _size) public {
        arrSize = _size;
    }

    function giveMeAnArray() public view returns (uint256[] memory){
        uint256[] memory arr = new uint256[](arrSize); 
        for(uint i=0; i<arrSize; i++){
            arr[i] = i+1; // or some other logic to fill array
        }
        return arr;
    }
}

