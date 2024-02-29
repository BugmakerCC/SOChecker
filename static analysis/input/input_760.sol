pragma solidity 0.8.7;

contract Master {
  uint p;

  function changep()public {
    p = 1;
  }

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

