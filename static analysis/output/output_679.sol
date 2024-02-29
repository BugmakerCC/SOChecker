pragma solidity ^0.8.9;
library PRBMathSD59x18 {


  function pow(int256 a, int256 b) internal pure returns (int256) {
    if (b == 0) {
       return 1;
    }
    int256 c = pow(a, b/2);
    return PRBMathSD59x18.mul(c, c);
  }

  function mul(int256 a, int256 b) internal pure returns (int256) {
    return (a * b) / 1000000000000000000;
  }

}

