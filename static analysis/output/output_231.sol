pragma solidity ^0.8.9;
contract NumbersCounter {

    uint[] IntArrayTest;

    function addElements(uint _number) public {
        Numbers memory numbers = Numbers(_number);
        IntArrayTest.push(numbers._number);
        elementsCounter +=1;
    }
 
    struct Numbers{
        uint _number;
    }

   uint elementsCounter = 0;
   
   Numbers[] NumbersArrayTest;

   function addNumbers(uint _number) public {
     NumbersArrayTest.push(Numbers(_number));
     elementsCounter +=1;
    }

    event NumbersAdded(uint _number);
 }

