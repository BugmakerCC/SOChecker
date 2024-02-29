pragma solidity ^0.8.9;
interface IRandomWords {
    function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) external;
}

