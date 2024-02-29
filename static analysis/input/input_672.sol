pragma solidity >=0.5.0 <0.9.0;

contract Practice {
    function arrLength(uint num) public pure returns(uint){
        uint[] memory arr = new uint[](num);
        for(uint i = 0; i < num; i++){
            arr[i] = 10;
        }
        uint leng= arr.length;
        return leng;
        }
}


