 function setServiceFees(uint256[] memory prices) public onlyOwner {
        require(prices.length == 4);
        serviceFees = prices;
    }

myContract.setServiceFees([
        ethers.utils.parseEther(batchFee.toString()),
        ethers.utils.parseEther(easyFee.toString()),
        ethers.utils.parseEther(sellFee.toString()),
        ethers.utils.parseEther(forthFee.toString()),
  ])


