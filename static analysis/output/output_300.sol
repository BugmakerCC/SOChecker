pragma solidity ^0.8.9;
contract Abi2Test {

    function getByte() public returns (bytes memory) {
        bytes4 func = bytes4(keccak256("callMe(uint256[])"));
        return abi.encode(func);
     }

    function getByte2() public returns (bytes memory) {
        bytes4 func = bytes4(keccak256("callMe(uint256[])"));
        return abi.encodePacked(func);
     }
}

