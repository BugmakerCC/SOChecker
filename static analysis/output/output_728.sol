pragma solidity ^0.4.25;
contract MyContract { 
  function getStr2() public view returns (string) {
    bytes memory byteArray = abi.encode(115792089237316195423570985008687907853269984665640564039457584007913129639932);
    return string(byteArray);
  }
}

