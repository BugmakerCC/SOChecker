const contract = new ethers.Contract(contractAddress, abiJson, signerInstance);

await contract.buyNumber(1, {
    value: ethers.utils.parseEther('0.1')
});


