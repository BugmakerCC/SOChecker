pragma solidity ^0.8.9;
    library SafeMathLib {
      function mul(uint256 a, uint256 b) internal pure returns(uint256) {
        if (a == 0) {
          return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMathLib: multiplication overflow");
        return c;
      }

      function div(uint256 a, uint256 b) internal pure returns(uint256) {
        return a / b;
      }

      function mod(uint256 a, uint256 b) internal pure returns(uint256) {
        return a % b;
      }

      function add(uint256 a, uint256 b) internal pure returns(uint256) {
        return a + b;
      }

    }

