pragma solidity ^0.8.9;
    interface ERC721URIStorage {
        function getNFTURI(uint256 tokenId)
            external
            view
            returns (string memory);
    }

    interface ERC721Enumerable {
        function tokensOfOwnerByIndex(address owner, uint256 index)
            external
            view
            returns (uint256 tokenId);
    }

    interface AccessControl {
        function hasRole(bytes32 role, address account)
            external
            view
            returns (bool);
    }

