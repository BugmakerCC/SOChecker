pragma solidity ^0.8.9;
library Lib {

function remove(uint[] storage _arr, uint _removedIndex) public returns(uint[] memory){
    require(_arr.length > 0, "No element in Array.");
    _arr[_removedIndex] = _arr[_arr.length-1];
    _arr.pop();
    return _arr;
}
}

