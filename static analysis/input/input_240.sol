 function generateRandomNumber(address _random) external(bytes32 requestId) {
        randomness_interface(_random).fulfillRandomness(uint256);
    }

  function fulfillRandomness(bytes32 requestId, uint256 randomness) 

function generateRandomNumber(address _random) external(bytes32 requestId) {
        randomness_interface(_random).fulfillRandomness(uint256);
    }

function fulfillRandomness(bytes32 requestId,uint256 randomNumber) internal override{

}


