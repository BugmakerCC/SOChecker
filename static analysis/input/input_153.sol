contract UQ112x112 {
    uint224 constant Q112 = 2**112;

    function encode(uint112 y) public pure returns (uint224 z) {
        z = uint224(y) * Q112; 
    }
    function uqdiv(uint224 x, uint112 y) public pure returns (uint224 z) {
        z = x / uint224(y);
    }
}

function encode(uint112 y) internal pure returns (uint224 z) {
      z = uint224(y) * Q112; 
  }

10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

function uqdiv(uint224 x, uint112 y) internal pure returns (uint224 z) {
   z = x / uint224(y);
} 


