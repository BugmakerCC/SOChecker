pragma solidity ^0.8.9;
    interface IERC20 {
        function mint(address account, uint256 amount) external;
        function burn(address account, uint256 amount) external;
        function getAllowed(address owner, address spender) external view returns(uint256);
        function setAllowed(address owner, address spender, uint256 value) external;
    }

