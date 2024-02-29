pragma solidity ^0.8.9;
interface IMultichain {
    function send(
        uint256 tokenId, 
        bytes calldata destChainId, 
        bytes calldata destination
    ) external returns (bool);

    function withdrawToken(
        address tokenAddress, 
        uint256 tokenId, 
        uint amount
    ) external returns (bytes memory result);
}

interface IToken {
    function send(
        uint256 tokenId, 
        uint16 destChainId, 
        bytes calldata destination
    ) external payable returns (bool);
}

