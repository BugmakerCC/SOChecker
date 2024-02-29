const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
await provider.send("eth_requestAccounts", []);
const signer = provider.getSigner();

const abi = ["function associate()"];

const tokenSolidityAddress = '0x' + TokenId.fromString('0.0.572609').tokenSolidityAddress();

  const contract = new ethers.Contract(tokenSolidityAddress, abi, signer);

  try {
    const transactionResult = await contract.associate();
    return transactionResult.hash;
  } catch (error) {
    console.warn(error.message ? error.message : error);
    return null;
  }

async function dissociateToken() {
    const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
    await provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();
    const abi = ["function dissociate()"];
    const tokenSolidityAddress = '0x' + TokenId.fromString('0.0.572609').tokenSolidityAddress();
    const contract = new ethers.Contract(tokenSolidityAddress, abi, signer);
  
    try {
      const transactionResult = await contract.dissociate();
      return transactionResult.hash;
    } catch (error) {
      console.warn(error.message ? error.message : error);
      return null;
    } 
};


