keccak256(addr.concat("5"))); 

keccak256(ethers.utils.solidityPack(["address", "string"], [addr, "5"]))


