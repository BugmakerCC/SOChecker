pragma solidity ^0.8.9;
contract Operator {

    function getPrice() public view virtual returns (uint256) {
        return 1 ether;
    }
}

