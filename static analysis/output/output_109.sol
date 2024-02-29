pragma solidity ^0.8.9;
     interface ainterface {
         function recive2ether() external payable;
     }

     contract a {
         bool public recived; 
         function recive2ether() external payable {
             require(msg.value >= 2 ether);
             recived = true;
         }
     }

     contract b {
         ainterface A;
         constructor (ainterface _A) {
             A = ainterface(_A);
         }

         function sendEthtoA() public payable {
             A.recive2ether{value: msg.value}();  
         }
     }

