pragma solidity ^0.4.25;
contract NFT {
    function ownerOf(uint256 tokenId) public view returns (address owner);
    function setApprovalForAll(address token, bool status) external;
    function giveResaleApproval(uint256 tokenId) public;
    address contractAddress = 0x742d69987876495964461777529248533330080;
}

