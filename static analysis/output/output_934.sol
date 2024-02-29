pragma solidity ^0.8.9;
contract NameStorage {
  
    mapping (address=>bytes8[] ) public Names;
    
    
    function getNames() public view returns (bytes8[] memory namesArray) { Names; }

   
}

