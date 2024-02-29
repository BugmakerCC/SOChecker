// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Master {
  uint p;

  function changep()public {
    p = 1;
  }

  // we use the view mutator, that way we tell the compiler that this function wont change the state of the blockchain ( change state variable p value ).
  function getP() public view returns(uint) {
    return p;
  }
}


contract CallerOne {

  Master m;

  constructor(address _m) {
    m = Master(_m);
  }

  function change1() public {
    m.changep();
  }

  function Get1() public view returns(uint) {
    return m.getP();
  }
}

contract CallerTwo {

  Master m;

  constructor(address _m) {
    m = Master(_m);
  }

  function change2() public {
    m.changep();
  }

  function Get2() public view returns(uint) {
    return m.getP();
  }
}
