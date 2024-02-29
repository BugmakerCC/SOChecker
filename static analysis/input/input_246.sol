function payment (address payable beneficiary) payable external{
  uint256 amount = msg.value;
  beneficiary.transfer(amount);
}

function payment(e){
 e.preventDefault();
 const nonce = await web3.eth.getTransactionCount(myAddress, 'latest');
 const data = project.methods.payment('0xe13DC66579940552574Cbe795410423609C2BFd9').encodeABI();
   
     }
const transaction = {
 'to': 'contract Address',
 'value': 100000000000000000, 
 'gas': 30000,
 'maxFeePerGas': 1000000108,
 'nonce': nonce,
};
const signedTx = await web3.eth.accounts.signTransaction(transaction, PRIVATE_KEY);

web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
if (!error) {
  console.log("🎉 The hash of your transaction is: ", hash, "\n Check Alchemy's Mempool to view the status of your transaction!");
} else {
  console.log("❗Something went wrong while submitting your transaction:", error)
}
});


