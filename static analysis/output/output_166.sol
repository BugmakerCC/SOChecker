pragma solidity ^0.8.9;
interface IERC20 {
    function balanceOf(address account)
        external view returns (uint256);
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

