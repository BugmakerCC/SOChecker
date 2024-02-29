pragma solidity ^0.8.9;
interface IERC20Receiver {
    function onERC20Receive(address from, uint256 amount) external returns (bool);
}

