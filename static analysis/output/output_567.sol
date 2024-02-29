pragma solidity ^0.8.9;
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        if (a == 0) {
            return 0;
        }
        c = a * b;
        require(c / a == b, 'SafeMath: multiplication overflow');
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        require(c >= a, 'SafeMath: addition overflow');
        return c;
    }
}

interface IERC20 {
    function balanceOf(address owner) external view returns (uint256);
}

