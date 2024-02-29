const alchemyKey = process.env.ALCHEMY_KEY;
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3(alchemyKey);
const contractABI = require('../contract-abi.json');
export const contract = new web3.eth.Contract(contractABI, CONTRACT_ADDRESS);

export const yourMethod = () => {
 if(window.ethereum.request({method: 'eth_requestAccounts'})){
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const address = await signer.getAddress();

  const tx = {
   from: address,
   to: CONTRACT_ADDRESS,
   value: "some wei value", 
   data: contract.methods.YOUR_CONTRACT_METHOD_HERE().encodeABI()
  }

  const txHash = await window.ethereum.request({
   method: 'eth_sendTransaction',
   params: [tx]
  });

  console.log({txHash});
 }else{
   console.log('user must connect wallet');
 }
}


