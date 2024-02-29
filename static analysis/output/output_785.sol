pragma solidity ^0.8.9;
    interface OefbContract {
        function mintNFT(address payable to, uint24 value) external payable;
        function transferFrom(address from, address to, uint24 value) external;
        function totalSupply() external view returns (uint24);
    }

