pragma solidity ^0.8.9;
contract EthereumAggregatorV2 {
    struct Round {
        uint256 phaseId;
        uint256 roundId;
        uint256 aggregatorRoundId;
    }

    constructor() public {}

    function getAggregatorRoundId(uint256 _phaseId, uint256 _aggregatorRoundId) public view returns(uint80) {
        return uint80(uint256(_phaseId) << 64 | _aggregatorRoundId);
    }
}

