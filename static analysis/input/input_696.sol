AGGREGATOR_ADDRESS=0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

require("dotenv").config();
const hre = require("hardhat");

async function main() {
    const factory = await hre.ethers.getContractFactory("Example");
    const contract = await factory.deploy(process.env.AGGREGATOR_ADDRESS);
    await contract.deployed();
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

pragma solidity ^0.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Example {
    AggregatorV3Interface internal priceFeed;

    constructor(address _aggregator) {
        priceFeed = AggregatorV3Interface(_aggregator);
    }
}


