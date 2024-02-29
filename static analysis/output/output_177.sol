pragma solidity ^0.8.9;
    abstract contract Context {
        function _sendTokenToAddress(address to, uint256 amount) internal virtual returns (bool);
    }

    abstract contract ERC20 {
        function safeTransferFrom(address from, address to, uint256 value) internal virtual returns (bool);
    }

