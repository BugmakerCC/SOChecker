pragma solidity ^0.8.9;
interface ERC1155 {
    function tokensOf(address tokenOwner) external view returns (uint256[] memory tokens);
}

