pragma solidity ^0.8.9;
contract Serializer {

  function hexStringToIntArray(string memory s) public pure returns (uint64[] memory) {
    uint size = bytes(s).length / 16;
    uint64[] memory result = new uint64[](size);
    for (uint i = 0; i< size; i++) {
      string memory strSlice = getSlice(i*16, (i+1)*16, s);
      result[i] = hexStringToInt(strSlice);
    }
    return result;
  }

  function getSlice(uint startIndex, uint endIndex, string memory str) public pure returns (string memory) {
    bytes memory strBytes = bytes(str);
    bytes memory result = new bytes(endIndex-startIndex);
    for(uint i = startIndex; i < endIndex; i++) {
      result[i-startIndex] = strBytes[i];
    }
    return string(result);
  }

  function hexBytesToInt(bytes memory ss) public pure returns (uint64){
    uint64 val = 0;
    uint8 a = uint8(97); 
    uint8 zero = uint8(48); 
    uint8 nine = uint8(57); 
    uint8 A = uint8(65); 
    uint8 F = uint8(70); 
    uint8 f = uint8(102); 
    for (uint i=0; i<ss.length; ++i) {
      uint8 byt = uint8(ss[i]);
      if (byt >= zero && byt <= nine) byt = byt - zero;
      else if (byt >= a && byt <= f) byt = byt - a + 10;
      else if (byt >= A && byt <= F) byt = byt - A + 10;
      val = (val << 4) | (byt & 0xF);
    }
    return val;
  }

  function hexStringToInt(string memory s) public pure returns (uint64) {
    bytes memory ss = bytes(s);
    uint64 val = hexBytesToInt(ss);
    return val;
  }
}

