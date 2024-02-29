function shuffle() internal {
    for (uint256 i = 0; i < dogs.length; i++) {
        uint256 n = uint256(keccak256(abi.encodePacked(randomNo))) % (numberArr.length - i) + i;

        String memory temp = dogs[n];
        dogs[n] = dogs[i];
        dogs[i] = temp;
    }
}


