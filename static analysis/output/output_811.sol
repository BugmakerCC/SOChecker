pragma solidity ^0.8.9;
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, " mul failed");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, " div by zero");
        return a / b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "sub failed");
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "add failed");

        return c;
    }
}

