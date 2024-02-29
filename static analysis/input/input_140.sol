pragma solidity ^0.8.9;

contract Lock {

    event DataStoredNonAnonymous(address admin, uint256 indexed data);
    event DataStoredAnonymous(address admin, uint256 indexed data) anonymous;
   
    uint256 x;
    uint256 y;
   
    function storeDataNonAnonymous(uint256 _data) external {
      x = _data;
      emit DataStoredNonAnonymous(msg.sender, _data);
    }

    function storeDataAnonymous(uint256 _data) external {
      y = _data;
      emit DataStoredAnonymous(msg.sender, _data);
    }

}

import { ethers } from "hardhat";

async function main() {
  const Lock = await ethers.getContractFactory("Lock");
  const lock = await Lock.deploy();

  await lock.deployed();

  console.log(`deployed to ${lock.address}`);
  const tx1 = await lock.storeDataNonAnonymous(10);
  const txReceipt1 = await tx1.wait()
  console.log("event non-anonymous",txReceipt1.events)

  const tx2 = await lock.storeDataAnonymous(12345);
  const txReceipt2 = await tx2.wait()
  console.log("event anonymous",txReceipt2.events)

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

Compiled 1 Solidity file successfully
deployed to 0x5FbDB2315678afecb367f032d93F642f64180aa3
event non-anonymous [
  {
    transactionIndex: 0,
    blockNumber: 2,
    transactionHash: '0x22e2b2c6274a83e0c6ff9e2733e7875940e038f3faf5641d77ede41958657fa0',
    address: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
    topics: [
      '0xe70463dc16bf49899544f11b2caa7874683dbf886102edb6cbc82d728dc425d4',
      '0x000000000000000000000000000000000000000000000000000000000000000a'
    ],
    data: '0x000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb92266',
    logIndex: 0,
    blockHash: '0x1491b08df4abb9ac8aaeb3be796ab0635957668224470944fd215400a02ce276',
    args: [
      '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
      BigNumber { value: "10" },
      admin: '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
      data: BigNumber { value: "10" }
    ],
    decode: [Function (anonymous)],
    event: 'DataStoredNonAnonymous',
    eventSignature: 'DataStoredNonAnonymous(address,uint256)',
    removeListener: [Function (anonymous)],
    getBlock: [Function (anonymous)],
    getTransaction: [Function (anonymous)],
    getTransactionReceipt: [Function (anonymous)]
  }
]
event anonymous [
  {
    transactionIndex: 0,
    blockNumber: 3,
    transactionHash: '0x76ec1eef5693031441fd0446ab681d3f703cca3a016167b343ad8d75fdfd478f',
    address: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
    topics: [
      '0x0000000000000000000000000000000000000000000000000000000000003039'
    ],
    data: '0x000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb92266',
    logIndex: 0,
    blockHash: '0xd4f64019225eb982522f8f41a1cc2d6869a7ac41f5d93e5b6f7fb39607914e78',
    removeListener: [Function (anonymous)],
    getBlock: [Function (anonymous)],
    getTransaction: [Function (anonymous)],
    getTransactionReceipt: [Function (anonymous)]
  }
]


