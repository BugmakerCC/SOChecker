pragma solidity ^0.8.9;
contract Test {

   int256 freeMints = 3;
   uint256 cost = 1000;
   uint256 freeMintCost = 0;
    
   function mint(int256 _mintAmount) public payable {
       int256 payableMints = int256(_mintAmount - freeMints);
       if(payableMints < 0){
        payableMints = 0;
       }
       if(payableMints > 0){
        require(msg.value >= (cost * uint256(payableMints)));
       }
       else{
        require(msg.value >= (freeMintCost * uint256(_mintAmount)));
       }
   }
}

