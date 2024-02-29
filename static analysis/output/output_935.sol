pragma solidity ^0.8.9;
contract Find {
    uint[10] private arr = [4, 6, 8, 12, 14, 16, 20, 22, 24];
   
    function funFind() public view returns(uint) {
        uint temp;
        for(uint i = 0; i < arr.length; i++) {
            temp = arr[i];
            for(uint j = 0; j < arr.length; j++) {
                if((j != i) && (temp == arr[j])) {
                    return temp;
                }
            }
        }
    }
}

