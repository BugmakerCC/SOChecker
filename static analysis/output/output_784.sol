pragma solidity ^0.8.9;
interface ITargetContract {
    function addCandidateIdToWhitelist(
        bytes32 _something,
        string memory _id
    ) external;

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function tokenOfWhitelist(uint256 index) external view returns(uint256 tokenId);
}

