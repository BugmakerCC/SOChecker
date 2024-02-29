pragma solidity ^0.4.25;
interface IAddress {
 function getCodeSize(bytes data) external returns (uint256);
 function codeSize(string memory _name) public pure returns (uint256);
}

