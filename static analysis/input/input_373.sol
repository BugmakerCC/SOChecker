mapping(address => Participant) public _participantMap;

function participate() external payable {
    require(msg.value == 2 ether,"The amount must be equal to 2 Ethers");
    if (_participantMap[msg.sender].participantAddr == address(0)) {
        _participantMap[msg.sender] = Participant(msg.sender, 1);
    } else {
        _participantMap[msg.sender].noOfLotts += 1;
    }
}

import { ethers } from "hardhat";

async function main() {
    const [owner, userOne, userTwo] = await ethers.getSigners();

    const contractAddress = process.env.LOTTERY_CONTRACT_ADDRESS;

    const Lottery = await ethers.getContractFactory("Lottery");
    const contractInstance = await Lottery.attach(`${contractAddress}`);
    await contractInstance.connect(userOne).participate({
        value: ethers.utils.parseUnits("2", "ether"),
    });

    const participant = await contractInstance._participantMap(`${userOne.address}`);
    console.log(participant);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

npx hardhat run scripts/2_participate.ts --network localhost
[
  '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
  BigNumber { value: "1" },
  participantAddr: '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
  noOfLotts: BigNumber { value: "1" }
]

npx hardhat run scripts/2_participate.ts --network localhost
[
  '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
  BigNumber { value: "2" },
  participantAddr: '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
  noOfLotts: BigNumber { value: "2" }
]

npx hardhat run scripts/2_participate.ts --network localhost
[
  '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
  BigNumber { value: "3" },
  participantAddr: '0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
  noOfLotts: BigNumber { value: "3" }
]

Compiled 1 Solidity file successfully
[
  '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC',
  BigNumber { value: "1" },
  participantAddr: '0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC',
  noOfLotts: BigNumber { value: "1" }
]


