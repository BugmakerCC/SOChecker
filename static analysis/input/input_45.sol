contract MyContract {
    uint256 protected myVar;
}

const myVar = await web3.eth.getStorageAt(contractAddress, slotNumber);


