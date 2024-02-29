pragma solidity ^0.4.16;
contract Main {
    
    string[6] public data;
    
    function get(uint number) external pure returns(string memory) {
        return data[number];
    }
}

