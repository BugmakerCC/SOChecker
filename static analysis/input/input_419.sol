import "./ContractA.sol"

contract ContractB {
   ContractA instanceOfA;
   
   function callA() public {
       instanceOfA.variableYouWantToAccess();
   }
}


