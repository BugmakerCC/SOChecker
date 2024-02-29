pragma solidity ^0.7.6;
    abstract contract Context {
        function _msgSender() internal virtual view returns (address payable) {
            if (msg.sender == address(0)) {
                return payable(msg.sender);
            } else {
                return msg.sender;
            }
        }
    }

