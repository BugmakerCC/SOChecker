pragma solidity ^0.4.25;
interface CandidateInterface {

    function getCandidateInfo(uint _candidateId) public view returns (uint, 
    string memory, string memory);

    
}

