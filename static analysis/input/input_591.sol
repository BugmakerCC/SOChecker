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


