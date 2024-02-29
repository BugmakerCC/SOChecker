pragma solidity ^0.8;

contract MyContract {

    address oracle = address(0x123);

    function requestNFTOwnerCheck(address owner, address collection, uint256 tokenID, uint16 chainID) external {
        (bool success, ) = oracle.call(abi.encode(owner, collection, tokenID, chainID));
        require(success);
    }

    function callback(bool result) external {
        require(msg.sender == oracle, "This function can be invoked only by the oracle");
    }
}


