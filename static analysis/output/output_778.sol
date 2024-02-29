pragma solidity ^0.8.9;
interface IMarketplace {
    function createMarketItem(
        address nftAddress,
        uint256 tokenId,
        uint256 priceFromForm,
        uint256 royalty,
        uint256 index
      )
      external
      returns (address);
  }

