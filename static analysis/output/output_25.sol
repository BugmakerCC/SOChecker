pragma solidity ^0.8.9;
contract MyMathLibrary {
    
    uint public addition = add(1,2);
    uint public product = multiply(add(2,3),add(2,1));
    
    function add(uint a,uint b)public pure returns(uint output){
        output = a+b;
    }
    
    function multiply(uint a,uint b)public pure returns(uint) {
        return a*b;
    }
}

