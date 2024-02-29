pragma solidity ^0.4.25;
contract Calculate {
  uint private c = 123;
  address separateContract;

  constructor(address _separateContract) {
    getC();
    separateContract = _separateContract;
  }

  function getC() public view returns (uint) {
    return c;
  }

  function add(uint _a, uint _b) public payable {
    separateContract.send(msg.value / 100); 
    c = _a + _b;
  }
}

