let signedMessage = `\x19Ethereum Signed Message:\n${signedMessage.length}${message}`;

function getSigner(string memory message, bytes memory sig) public view returns(address) {
   bytes32 messageHash = keccak256(abi.encodePacked(message));
   address signer = ECDSA.recover(messageHash, sig);
   return signer;
}

let prefixedMessage = `\x19Ethereum Signed Message:\n${message.length}${message}`
  address = await mycontract.getSigner(prefixedMessage, signature);


