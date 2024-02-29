function returnStuff() public returns (uint256, uint256) {
   return (1, 3);
}

( , uint256 ourNum) = returnStuff();


