// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Test {
    uint[2] votes = [0,0];
    address owner;

    // NOTE: I set a 'owner' variable with the address value who have deployed for the first time the smart contract
    constructor() {
        owner = msg.sender;
    }

    // NOTE: Modifier that allow only for smart contract owner the access to specific function
    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the owner!");
        _;
    }

    function vote_a() public{
        votes[0] += 1;
    }

    function vote_b() public{
        votes[1] += 1;
    }

    function results() public view returns(string memory){
        uint a = votes[0];
        uint b = votes[1];
        
        if (a==b)
            return "tie";
        else if (a>b)
            return "a wins";
        else
            return "b wins";
    }

    // NOTE: I created a new function that allows you to handle the data inside array
    function setResults() public onlyOwner {
        votes[0] = 0;
        votes[1] = 0;
    }

}

