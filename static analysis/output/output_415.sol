pragma solidity ^0.8.9;
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract MyContract {
    function SeeBalance(IERC20 token) public view returns (uint256) {
       return IERC20(token).balanceOf(address(this));
    }
}

