pragma solidity ^0.8.9;
interface IResponse {
    function get(uint256 _tokenId) external view returns (address recipient, uint256);
}

