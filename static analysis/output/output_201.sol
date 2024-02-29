pragma solidity ^0.8.9;
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function addMod(uint256 a, uint256 b, uint256 modulus) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a && c < modulus, "SafeMath: addition overflow");

        return c;
    }

    function multiply(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function subtractMod(uint256 a, uint256 b, uint256 modulus) internal pure returns (uint256) {
        uint256 c = a - b;
        require(c >= a && c < modulus, "SafeMath: subtraction overflow");

        return c;
    }
}

