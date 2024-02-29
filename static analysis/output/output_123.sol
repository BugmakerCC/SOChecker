pragma solidity ^0.8.9;
contract SafeMath {

    
 function mul( uint a, uint b ) internal pure returns (uint) {
  if (a == 0) {
    return 0;
  }

  uint c = a * b;
  assert(c / a == b);
  return c;
}

    
 function div(uint a, uint b) internal pure returns (uint) {
    
  return a / b;
}

    
 function mod(uint a, uint b) internal pure returns (uint) {
    return a % b;
}

    
 function sub(uint a, uint b) internal pure returns (uint) {
    assert(b <= a);
    return a - b;
}

    
 function add(uint a, uint b) internal pure returns (uint) {
    uint c = a + b;
    assert(c >= a);
    return c;
}

}

