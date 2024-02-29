pragma solidity ^0.8.9;
library SafeMath {

    function tryAdd(uint256 a, uint256 b) internal pure returns (bool) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return true;
    }

    function trySub(uint256 a, uint256 b) internal pure returns (bool) {
        if (b > a) return false;
        uint256 c = a - b;
        require(c >= 0, "SafeMath: subtraction underflow");
        return true;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a + b);
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a - b);
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }
}

