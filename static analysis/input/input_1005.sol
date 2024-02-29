pragma solidity ^0.4.17;

contract dynamic_array
{
    int[] public myArray;
    int x;
    int y;

    function dynamic_array() public {
        x = x + 2;
        y = 5;
        myArray.push(1);
    }
}


