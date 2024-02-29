pragma solidity ^0.7.6;
contract LuckyDraw {
    address payable[] public players;
    uint public amount = 0.01 ether;

    function participate() public payable {
        require(msg.value == amount, "Participation fee is 0.01 Ether");
        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    function draw() public {
        uint index = random() % players.length;
        uint prize = address(this).balance;
        payable(players[index]).transfer(prize);

        // Reset the players
        delete players;
    }

    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }
}

