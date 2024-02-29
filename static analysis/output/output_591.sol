pragma solidity ^0.8.9;
 library LibDiv128x128 {

    function div128x128 (uint256 x, uint256 y) internal pure returns (uint256) {
        unchecked {
            require (y != 0);
            uint256 xDec = x & 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
            uint256 xInt = x >> 128;
            uint256 hi = xInt*(MAX_128x128/y);
            uint256 lo = (xDec*(MAX_128x128/y))>>128;
            
            require (hi+lo <= MAX_128x128);
            return hi+lo;
        }
    }
    
    
    
    
    
    
    
    
    
    uint256 constant MAX_128x128 = uint256(1)<<128;

 }

