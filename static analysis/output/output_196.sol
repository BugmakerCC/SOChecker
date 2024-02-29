pragma solidity ^0.8.9;
 contract helloGeeks {
  int[] public numbers;
 
  function Numbers() public
  {
    numbers.push(1);
    numbers.push(2);
 
    int[] storage myArray = numbers;
     
    myArray[0] = 0;
  } 
}

