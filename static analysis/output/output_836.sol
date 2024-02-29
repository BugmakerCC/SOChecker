pragma solidity ^0.8.9;
library SafeMath {
    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }
    
    
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    
    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    
    function allowance(address owner, address spender) external view returns (uint256);
    
    function transferFrom(address owner, address recipient, uint256 amount) external returns (bool);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    function approve(address spender, uint256 amount) external returns (bool);
    
    function permit() external;
    
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

