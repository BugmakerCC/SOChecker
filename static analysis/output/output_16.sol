pragma solidity ^0.4.25;
contract Converter {

  function convertFromTronInt(uint256 tronAddress) public view returns(address) {
      return address(tronAddress);
  }
}

