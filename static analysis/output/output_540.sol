pragma solidity ^0.8.9;
abstract contract Context {
    function _messageSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _decimal() internal pure returns (uint) {
        return 10 ** uint256(1);
    }
}

