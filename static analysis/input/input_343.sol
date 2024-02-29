const contract = new ethers.Contract(contractAddress, ABI, signer);

const returnedValue = await contract.someMethod(someArgument)


