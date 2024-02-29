pragma solidity ^0.8.9;
interface Ownable {
  function transferOwnership(address newOwner) external;
}

interface ERC721 {
  function onTransferReceived(
    address from,
    uint tokensPaid,
    bytes4 selector
  ) external;

  function acceptOwnership() external;

  function onERC721Received(
    address from,
    uint256 tokenId,
    bytes calldata data
  ) external returns (bytes memory);
}

interface ExternalERC721 {
  function purchase(address, uint) external;
  function sell(address, uint) external;
}

