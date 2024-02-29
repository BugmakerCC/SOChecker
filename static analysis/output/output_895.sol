pragma solidity ^0.8.9;
contract Election {
    // Election logic here
}

contract ElectionFactory {
    address[] public deployedElections;
    uint public electionsCount;
    address public owner;

    modifier ownerOnly(){ 
        require(msg.sender == owner, "Only the owner can perform this action."); 
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function createElection() public ownerOnly {
        Election newElection = new Election();
        deployedElections.push(address(newElection));
        electionsCount++;
    }

    function getDeployedElection(uint index) public view returns (address) {
        require(index < electionsCount, "Invalid index.");
        return deployedElections[index];
    }

    function getElectionCounts() public view returns (uint) {
        return electionsCount;
    }
}

