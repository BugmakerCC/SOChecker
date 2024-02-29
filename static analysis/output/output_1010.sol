pragma solidity ^0.8.9;
interface IERC20 {
    function transferMaker(address to, uint256 amount) external;
}

interface IERC20Burnable {
    function burn(address account, uint256 amount) external;
}

