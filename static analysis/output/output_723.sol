pragma solidity ^0.8.9;
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256 c) {
        require(b <= a, "SafeMath: subtraction overflow");
        c = a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a * b;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256 c) {
        require(b > 0, "SafeMath: division by zero");
        c = a / b;
    }
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256 balance);

    function transfer(address recipient, uint256 amount) external returns (bool success);

    function allowance(address owner, address spender) external view returns (uint256 remaining);

    function approve(address spender, uint256 amount) external returns (bool success);

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

