pragma solidity ^0.8.9;
contract DogShuffler {
    string[] public dogs;
    uint256 public randomNo;

    function addDog(string memory _dog) public {
        dogs.push(_dog);
    }

    function setRandomNo(uint256 _randomNo) public {
        randomNo = _randomNo;
    }

    function shuffle() internal {
        for (uint256 i = 0; i < dogs.length; i++) {
            uint256 n = uint256(keccak256(abi.encodePacked(randomNo))) % (dogs.length - i) + i;

            string memory temp = dogs[n];
            dogs[n] = dogs[i];
            dogs[i] = temp;
        }
    }

    function shuffleDogs() public {
        shuffle();
    }
}

