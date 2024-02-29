pragma solidity ^0.8;

contract MyContract {
    function foo() external pure returns (uint8) {
        uint16 larger = 512;           
        uint8 smaller = uint8(larger); 
        return smaller;
    }
}

10101011 11001101 10101011 11001101 
10101011 11001101 10101011 11001101 
10101011 11001101 10101011 11001101 
10101011 11001101 10101011 11001101 
00000000 00000000 00000000 00000000 


