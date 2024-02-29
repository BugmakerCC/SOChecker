pragma solidity ^0.8.9;
interface EthECKey {
    function sign(bytes calldata _message) external returns (bytes memory _signature);
}

