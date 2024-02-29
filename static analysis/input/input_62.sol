web3.eth.accounts.wallet.add("0xprivateKey");

await contract.methods.sendToOwner().send(
    { from: currentAccount.address, gas: 300000 }
);

const web3 = new Web3(window.ethereum);

await contract.methods.sendToOwner().send(
    { from: currentAccount.address, gas: 300000 }
);


