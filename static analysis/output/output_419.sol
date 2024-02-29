pragma solidity ^0.4.25;
contract ContractA {
    string public variableYouWantToAccess;
    
    function variableYouWantToAccess() public view returns(string) {
        return variableYouWantToAccess;
    }
}

contract ContractB {
   ContractA instanceOfA;
   
   function callA() public {
       instanceOfA.variableYouWantToAccess();
   }
   
   function setInstanceOfA(address _instanceOfA) public {
       instanceOfA = ContractA(_instanceOfA);
   }
}

