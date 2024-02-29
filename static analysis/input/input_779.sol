 var abiEnconde = new ABIEncode();

 var resultHash = abiEnconde.GetSha3ABIEncodedPacked(
          new ABIValue("address", msg1),
          new ABIValue("uint256", amount),
          new ABIValue("uint256", nonce));

 var messageHashed = "0x" + Convert.ToHexString(resultHash).ToLower();
 var signature1 = signer1.Sign(resultHash, new EthECKey(privateKey));

function getMessageHash(address add,uint256 amount,uint256 nonce ) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(add,amount,nonce)); 
}

 bytes memory prefix = "\x19Ethereum Signed Message:\n32";
 bytes32 prefixedHashMessage = keccak256(abi.encodePacked(prefix,getMessageHash(msg1,amount,nonce)));
    
 address signer = ecrecover(prefixedHashMessage, _v, _r, _s);


