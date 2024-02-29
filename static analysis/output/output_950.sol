pragma solidity ^0.8.9;
contract FancyGas {
    function payGas(address _to, uint _amount) public payable {
     (bool success, bytes memory data) = payable(_to).call{value: _amount}("");
    require(success, "Call failed.");
  }
}

