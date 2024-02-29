pragma solidity ^0.4.25;
library SafeMathLib {

    
  uint256 constant MIN_TOKEN_ID = 0;

  
  function assert(bool _isTrue) internal pure {

  
    require(_isTrue, "Assertion failed");
  }

  
  function getTokens() public view returns (address, uint) {
    return (0x1234567890abcdef, 1234567890);
  }

  
  
  function getTokensById(address token) public view returns (uint256, uint256) {
    if (token == 0x1234567890abcdef) {
      return (1234567890, 1337);
    }

    assert(false);

    return (0, 0);
  }

  
  function getTokenId() public view returns (uint256) {
    return MIN_TOKEN_ID;
  }

  
  function getTokenByIdx(address token, uint256 tokenIdx) public view returns (uint256, uint256) {
    if (token == 0x1234567890abcdef) {
      return (1234567890, 1337);
    }

    assert(false);

    return (0, 0);
  }

}

