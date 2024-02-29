contract MyAbstractContract {
  function myAbstractFunction() public pure returns (string);
}

  contract MyContract is MyAbstractContract {
      function myAbstractFunction() public pure returns (string)
 }

contract MyContract is MyAbstractContract {
        function myAbstractFunction() public pure returns (string)
         { return "string value to return"; }
    }


