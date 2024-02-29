pragma solidity ^0.8.9;
  interface MyInterface {
    function changeVariable() external;
    function randomFunction() external;
  }

  contract ContractInherits {
    uint256 public a_variable;

    function changeVariable() public {
        a_variable = a_variable++;
    }  
  }

