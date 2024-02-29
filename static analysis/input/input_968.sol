const sendToContractTx = await owner.sendTransaction({
  to: betContract.address,
  value: ethers.utils.parseEther("1.0")
});

contract BetToken is ERC20, Ownable {
    receive() external payable {}
}


