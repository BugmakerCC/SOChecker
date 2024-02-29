    if (response != HederaResponseCodes.SUCCESS && newTotalSupply==0) {
        return(false,0,_nftOwner);
    }
    else{
        
        transferNft(tokenId,_nftOwner,serialNumbers[0]);
        NftToSeller[serialNumbers[0]]=_nftOwner;
        return(true,serialNumbers[0],_nftOwner);
    }
}


