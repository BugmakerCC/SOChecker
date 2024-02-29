transaction = await contract.createMarketItem(
      nftAddress,
      tokenId,
      { value: (listingPrice) },
      royalty,
      index
    );

transaction = await contract.createMarketItem(
          nftAddress,
          tokenId,
          priceFromForm,
          royalty,
          index, 
          { value: (listingPrice) }

        );


