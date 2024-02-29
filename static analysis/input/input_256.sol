const bytesHex = web3.eth.abi.encodeParameters(
    ['address', 'uint256'],
    ['0xde0B295669a9FD93d5F28D9Ec85E40f4cb697BAe', '1']
);

pragma solidity ^0.8;

contract MyContract {
    function foo2(address param1, uint256 param2) external {
    }
    
    function foo1(bytes memory params) external {
        (address decodedAddress, uint256 decodedUint) = abi.decode(params, (address, uint256));
        this.foo2(decodedAddress, decodedUint);
    }
}


