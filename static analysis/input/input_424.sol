function getCandidateInfo(uint _candidateId) public view returns (uint, 
string memory, string memory) {

    Candidate memory candidate=candidatesMap[_candidateId]
    return(
        candidate.candidateId,
        candidate.CandidateName,
        candidate.party
    );
}


