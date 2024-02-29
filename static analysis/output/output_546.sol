pragma solidity ^0.8.9;
library Greeter {
  function greet()public view returns (string memory) {
    return "Salut!";
  }
}

contract Greeter_ {
   function greet()public view returns (string memory) {
      return Greeter.greet();
    }
}

