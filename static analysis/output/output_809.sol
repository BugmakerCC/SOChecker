pragma solidity ^0.4.25;
contract SECP256K1 {
    function recover(
        uint256 r,
        uint8 s,
        uint256 v
    ) public pure returns (uint256 x, uint256 y);
}

