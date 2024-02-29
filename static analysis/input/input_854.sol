function isContract(address addressValue) public view returns (bool) {
    uint size;
    assembly { size := extcodesize(addressValue) }
    return size > 0;
}

'

 pragma solidity 0.8.7;

 contract ContractIdentifier{

      function isContract(address addressValue) public view returns (bool) {
          uint size;
          assembly { size := extcodesize(addressValue) }
          return size > 0;
      }
 }


