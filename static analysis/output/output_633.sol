pragma solidity ^0.8.9;
interface IIntrospectionEmitter {
    function getIntrospection(bytes calldata) external returns (uint256);
}

