 hardhat: {
      allowUnlimitedContractSize: true,
    }

import "ContractA.sol";
contract Factory {
 A public a;
 function createA() public {
   a = new A();
 }
}


