pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyContract {
    function batchTransfer(address token1, address token2, address from, address to, uint256 amount) public {
        bool success1 = IERC20(token1).transferFrom(from, to, amount);
        bool success2 = IERC20(token2).transferFrom(from, to, amount);
    }
}


