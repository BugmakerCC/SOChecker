pragma solidity ^0.8.9;
contract LotteryProject {
    address public owner;
    address public addressofwinner;
    address payable[] public participants;
    
    receive() external payable {}
    
    constructor() payable {
        owner = msg.sender;
    }

    function depositEthers() public payable {
        require(msg.value == 10 ether, "10 ethers are required to participate in this lottery");
        participants.push(payable(msg.sender));
    }

    function totalDeposits() public view returns (uint) {
        require(msg.sender == owner, "Only owner is authorized to check the total deposits");
        return address(this).balance;
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length)));
    }

    function winner() public {
        require(msg.sender == owner);
        require(participants.length >= 3);

        uint r = random();
        uint index = r % participants.length;
        address payable winner = participants[index];
        addressofwinner = winner;
        winner.transfer(totalDeposits());
        participants = new address payable[](0);
    }
}

