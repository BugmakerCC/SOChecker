uint256 randomness = uint(keccak256(abi.encodePacked(msg.sender, block.difficulty, block.timestamp)));

    function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) internal override {
        uint256 randomness = _randomWords[0];
    }


