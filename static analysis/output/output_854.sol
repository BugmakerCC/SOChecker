pragma solidity ^0.8.9;
contract ContractIdentifier {

  
  function isContract(address addressValue) public view returns (bool) {
       uint size;
       assembly { size := extcodesize(addressValue) }
       return size > 0;
    }
 }

