pragma solidity ^0.8.9;
interface IERC20Upgradeable {
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function safeIncreaseAllowance(address spender, uint256 value) external;
    function safeDecreaseAllowance(address spender, uint256 value) external;
}

interface IWETH9 {
    function depositWeth() external payable;
    function withdrawEther(uint256 amount) external;
}

