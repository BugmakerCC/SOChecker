pragma solidity ^0.8.0;

contract SignTest {

address owner = msg.sender;

mapping(uint256 => bool) usedNonces;

function test(uint256 amount, uint256 nonce, bytes memory sig, uint tV, bytes32 tR, bytes32 tS, bytes32 tMsg) public view returns(address) {

    bytes32 message = prefixed(keccak256(abi.encodePacked(amount, nonce))); 
    bytes32 messageWithoutPrefix = keccak256(abi.encodePacked(amount, nonce)); 

   
    address signer = recoverSigner(messageWithoutPrefix, sig, tV, tR,tS);

    return signer;
}


function splitSignature(bytes memory sig)
    public
    view
    returns (uint8, bytes32, bytes32)
{
    require(sig.length == 65, "B");

    bytes32 r;
    bytes32 s;
    uint8 v;

    assembly {
        r := mload(add(sig, 32))
        s := mload(add(sig, 64))
        v := byte(0, mload(add(sig, 96)))
    }

    return (v, r, s);
}

function recoverSigner(bytes32 message, bytes memory sig, uint tV, bytes32 tR, bytes32 tS)
    public
    view
    returns (address)
{
    uint8 v;
    bytes32 r;
    bytes32 s;

    (v, r, s) = splitSignature(sig);

    require(v==tV, "V is not correct");
    require(r==tR, "R is not correct");
    require(s==tS, "S is not correct");

    return ecrecover(message, v, r, s);
}

function prefixed(bytes32 inputHash) public pure returns (bytes32) {
    return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", inputHash));
}

}

    let fnSignature = web3.utils.keccak256("setApprovalForAll(address,bool").substr(0,10)

let fnParams = web3.eth.abi.encodeParameters(
  ["address","bool"],
  [toAddr,permit]
)

calldata = fnSignature + fnParams.substr(2)

console.log(calldata)

const data = calldata 
const NFTAddress = 'Contract address where you sign'
const newSigner = web3.eth.accounts.privateKeyToAccount("Your Priv Key");
const myAccount = web3.eth.accounts.wallet.add(newSigner);
const signer = myAccount.address;
console.log(signer) 

    let rawData = web3.eth.abi.encodeParameters(
    ['address','bytes'],
    [NFTAddress,data]
  );
  let hash = web3.utils.soliditySha3(rawData);
  console.log(hash)
  let signature = web3.eth.sign(hash, signer);
 console.log(signature)


