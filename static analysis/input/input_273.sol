pragma solidity >=0.7.0 <0.9.0;

contract Test {

     function testTransfer() external payable {}
     function getBalance() external view returns (uint256) {
       return address(this).balance;
     }
}


