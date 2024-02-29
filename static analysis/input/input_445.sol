pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract ContractA {
    event Received(address sender, uint value);

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    function deposit() public payable{
        require(msg.value >= 0, "Value amount to be deposit");
        withdraw(msg.value);
    }

    function withdraw(uint256 _amount) internal{
        console.log(_amount);
        uint256 amount = 2 * _amount; 
        console.log(amount);
        payable(msg.sender).transfer(amount);
    }
}

import { ethers } from "hardhat";

const hre = require("hardhat");
async function main() {
  const [owner] = await hre.ethers.getSigners();

  const deposit = await ethers.getContractFactory("ContractA");
  const depositInstance = await deposit.deploy();
  await depositInstance.deployed();

  const depositContract = await hre.ethers.getContractFactory("ContractA");
  const instance = await depositContract.attach(`${depositInstance.address}`);

  const contractBalance = await hre.ethers.provider.getBalance(
    `${depositInstance.address}`
  );
  console.log("contract balance before tx", contractBalance.toString());

  await owner.sendTransaction({
    to: depositInstance.address,
    value: ethers.utils.parseUnits("100", 18),
  });
  const contractBalanceAfter = await hre.ethers.provider.getBalance(
    `${depositInstance.address}`
  );
  console.log("contract balance after tx", contractBalanceAfter.toString());

  const ownerBalance = await hre.ethers.provider.getBalance(`${owner.address}`);
  console.log(
    `Owner balance before deposit ${ethers.utils.formatUnits(
      ownerBalance.toString(),
      18
    )}`
  );
  await instance
    .connect(owner)
    .deposit({ value: ethers.utils.parseUnits("5", 18) });

  const contractBalanceAfterContract = await hre.ethers.provider.getBalance(
    `${depositInstance.address}`
  );
  console.log(
    "contract after contract interaction",
    contractBalanceAfterContract.toString()
  );

  const ownerBalanceAfter = await hre.ethers.provider.getBalance(
    `${owner.address}`
  );
  console.log(
    `Owner balance before deposit ${ethers.utils.formatUnits(
      ownerBalanceAfter.toString(),
      18
    )}`
  );
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

Compiled 1 Solidity file successfully
contract balance before tx 0
contract balance after tx 100000000000000000000
Owner balance before deposit 9899.999469435601476844
5000000000000000000
10000000000000000000
contract after contract interaction 95000000000000000000
Owner balance before deposit 9904.999416266040763879


