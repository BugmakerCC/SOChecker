pragma solidity ^0.4.17;

contract dynamic_array
{
    int[] public myArray;
    int x;
    int y;

    // Constructor in version 0.4
    // is a `public` function with the same name as the contract
    function dynamic_array() public {
        x = x + 2;
        y = 5;
        myArray.push(1);
    }
}

