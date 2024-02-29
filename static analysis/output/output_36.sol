pragma solidity ^0.4.25;
contract ERC20_HEX {
    function approve(address owner, address spender, uint256 tokenId) external returns (bool);
}

contract HEX_ERC20 {
    event Approval(address indexed owner, address indexed spender, address indexed tokenId);

    function transferFrom(address from, address to, uint256 tokenId) external returns (bool);

    function approve(address owner, address spender, uint256 tokenId) external returns (bool);
}

contract ERC1155_HEX {
    event Approval(address indexed owner, address indexed spender, uint256 indexed tokenId);

    function setApprovalForAll(address owner, address spender, bool approved) external;

    function approveAll(address spender) external;

    function getApproved(address token, uint256 tokenId) external view returns (bool);
}

