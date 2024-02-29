pragma solidity ^0.8.9;
interface IERC1363 { function onTransferReceived(address operator, address sender, uint256 tokensPaid, bytes calldata data) external returns (bytes4); }

