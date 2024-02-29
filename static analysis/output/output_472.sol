pragma solidity ^0.8.9;
contract PayableToken {
    receive() external payable {}
    fallback() external payable {}
}

