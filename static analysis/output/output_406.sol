pragma solidity ^0.8.9;
contract Bank {
  
  mapping(address => uint256) public balance;

  function deposit() external payable {
  balance[msg.sender] += msg.value;
}

function withdraw() external {
  msg.sender.call{value: balance[msg.sender]}(""); 
  balance[msg.sender] == 0; 
} 

function withdrawV2(uint256 value) external{
  require(value <= balance[msg.sender], "you don't have that much"); 
  msg.sender.call{value: balance[msg.sender]}("");
  unchecked { 
    balance[msg.sender] -= value;
  }
}


}

