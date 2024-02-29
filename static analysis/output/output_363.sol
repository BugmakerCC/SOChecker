pragma solidity ^0.8.9;
interface IERC721 {
    function balanceOf(address account) external view returns (uint256 balance);
}

interface IERC1155 {
    function balanceOf(address account) external view returns (uint256 balance);
}

