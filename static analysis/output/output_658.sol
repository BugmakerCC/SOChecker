pragma solidity ^0.8.9;
interface IERC20 {
    function totalSupply() external view returns (uint supply);
    function balanceOf(address account) external view returns (uint balance);
    function transfer(address recipient, uint amount) external returns (bool success);
    function allowance(address owner, address spender) external view returns (uint remaining);
    function approve(address spender, uint amount) external returns (bool success);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool success);
  }

  interface IERC721 {
    function safeMint(address to, uint256 tokenId) external;
    function unsafeMint(address to, uint256 tokenId) external;
    function unsafeBurn(uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address operator);
    function setApprovalForAll(address operator, bool _approved) external;
    function isApprovedForAll(address operator, address account) external view returns (bool);
    function safeBatchMint(address[] calldata to, uint256[] calldata tokenIds)
      external;
    function safeBatchBurn(uint256[] calldata tokenIds)
      external;
  }

  abstract contract MyContract {
    receive() external payable {}
  }

  contract NFT {
  
    receive() external payable {
    }
  }

