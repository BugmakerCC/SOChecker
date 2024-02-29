pragma solidity ^0.4.17;
 
contract helloGeeks
{
  int[] public numbers;
 
  function Numbers() public
  {
    numbers.push(1);
    numbers.push(2);
 
    int[] storage myArray = numbers;
     
    myArray[0] = 0;
  } 
}

pragma solidity ^0.4.17;
 
contract helloGeeks
{ 
  int[] public numbers;
   
  function Numbers() public
  {
    numbers.push(1);
    numbers.push(2);
     
    int[] memory myArray = numbers;
     
    myArray[0] = 0;
  } 
}

mapping(key => value) <name>;

contract helloGeeks
{ 
  mapping(address => uint) balance;
   
 
  function Insert(address _user, uint _amount) public
  {
    balance[_user] = _amount
  } 

  function View(address _user) public view returns(uint)
  {
    return balance[_user];
  } 
}


