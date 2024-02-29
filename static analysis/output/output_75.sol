pragma solidity ^0.8.9;
interface ERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

interface ReentrancyGuard {
    function tokenReentrancy() external view returns (bool);
}

