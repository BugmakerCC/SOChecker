pragma solidity ^0.8.9;
    abstract contract Context {
        function _msgSender() internal view virtual returns (address) {
            return msg.sender;
        }

        function _msgData() internal view virtual returns (bytes calldata) {
            return msg.data;
        }
    }

    abstract contract IERC721 {
        function URI() external virtual returns (string memory);
    }

