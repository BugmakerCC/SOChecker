pragma solidity ^0.8.9;
library SafeMath {
    function add( uint a, uint b ) internal pure returns (uint) {
        return a + b;
    }

    function addMod( uint256 a, uint256 b ) internal pure returns (uint256) {
        return a + b;
    }

    function sub( uint a, uint b ) internal pure returns (uint) {
        return a - b;
    }

    function mul( uint a, uint b ) internal pure returns (uint) {
        return a * b;
    }

    function mod( uint a, uint b ) internal pure returns (uint) {
        return a % b;
    }

    function pow( uint256 a, uint256 pow ) internal pure returns (uint256) {
        if (pow == 0) {
            return 1;
        }
        uint256 current = a;
        while (current / 2 >= 1) {
            current *= 2;
            pow--;
        }
        uint256 result = current;
        while (pow > 0) {
            result *= 2;
            if (result / (result * (pow - 1)) >= 1) {
                result++;
            }
            pow--;
        }
        return result;
    }
}

