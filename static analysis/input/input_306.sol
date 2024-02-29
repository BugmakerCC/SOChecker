  function setRandomNumberGenerator(address _randomNumberGenerator) external onlyOwner {
    randomNumberGenerator = IRandomNumberGenerator(_randomNumberGenerator);
  }


