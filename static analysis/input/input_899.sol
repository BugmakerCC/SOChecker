function isBitSet(uint256 b, uint256 pos) public pure returns (bool) {
        return ((b >> pos) & 1) == 1;
    }


