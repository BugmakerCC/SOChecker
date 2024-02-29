//SPDX-License-Identifier: MIT;
pragma solidity ^0.8.0;

interface IERC20{
    function balanceOf(address owner) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from,address to,uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

interface IERC721{
    function balanceOf(address owner) external view returns (uint256);
    function setApprovalForAll(address operator, bool _approved) external;
    function safeTransferFrom(address from,address to,uint256 tokenId) external;
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
}

contract Vote  {
    constructor (){}

    uint public candidateId = 0;
    uint public electionId= 0;
    mapping (uint => Election) public allElections;
    mapping(uint => Candidate) allCandidates;
    mapping(uint => mapping(address => bool)) public voted;
    string public tie;
    


    struct Election {
        uint electionId;
        address creator;
        address identifier;
        string details;
        bool active;
        Candidate[] candidates;
    }

    struct Candidate{
        uint electionId;
        uint candidateId;
        string name;
        uint vote;
    }

    function setUp( address _identifier, string memory _details , string[] calldata _candidate) public {  
        electionId++;
        // NOTE: I retrieve an empty election struct from mapping and set for each field the values.  
        Election storage election = allElections[electionId];
        election.electionId = electionId;
        election.creator = msg.sender;
        election.identifier = _identifier;
        election.details = _details;
        election.active = true;

        for(uint i = 0; i < _candidate.length; i++){
            candidateId++;
            Candidate memory candidate = Candidate(electionId,candidateId,_candidate[i],0);
            allCandidates[candidateId] = candidate;
            // NOTE: For insert the candidates inside the same election struct, I use election struct retrieved in line 51 and 
            //       then use 'push' method for add single candidate
            election.candidates.push(candidate);
        }
    }

    function start(uint _electionId) public {
        require(allElections[_electionId].creator == msg.sender, "only moderator can start an election");
        allElections[_electionId].active = true;
           }
    
    function vote(uint _candidateId,uint _electionId ) public {
        require(voted[_electionId][msg.sender] == false, "you have already voted");
        require(allElections[_electionId].active == true, "election have not begun");
        address identifier = allElections[_electionId].identifier;
        require(IERC20(identifier).balanceOf(msg.sender) > 0 || IERC721(identifier).balanceOf(msg.sender) > 0,"only registered voters can vote");

        allCandidates[_candidateId].vote++;


        voted[_electionId][msg.sender] = true;
    }
    
    function announce(uint _electionId) public  returns (Candidate[] memory,string memory) {
        require(allElections[_electionId].creator == msg.sender, "only moderators can announce winner");
        allElections[_electionId].active = false;

        Candidate[] memory contestants = new Candidate[](candidateId);
        uint winningVoteCount = 0;
        uint256 winnerId;
        uint winningCandidateIndex = 0;
        for(uint i =0; i < candidateId ; i++){
            if(allCandidates[i + 1].electionId == _electionId){
                if (allCandidates[i + 1].vote > winningVoteCount){
                     winningVoteCount = allCandidates[i + 1].vote;
                     uint currentId = allCandidates[i + 1].candidateId;
                        winnerId= currentId;

                      Candidate storage currentItem = allCandidates[currentId];
                    contestants[winningCandidateIndex] = currentItem;
                    winningCandidateIndex += 1;
                        tie="";
                }else if(allCandidates[i + 1].vote == winningVoteCount){
                    tie = "This ended in a tie";
                }
                
            }
        }
       
    return (contestants, tie);
}

function booth() public view returns (Election[] memory){

         uint currentIndex = 0;
         uint total = electionId;

        Election[] memory items = new Election[](total );

        /// @notice Loop through all items ever created
        for (
            uint i = 0;
            i < electionId;
            i++) {
            
            /// @notice Get only public item
            if (allElections[i + 1].active == true) {
                uint currentId = allElections[i + 1].electionId;
                Election storage currentItem = allElections[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
   
    }

function myElections() public view returns (Election[] memory){

         uint currentIndex = 0;
         uint total = electionId;

        Election[] memory items = new Election[](total);

        /// @notice Loop through all items ever created
        for (
            uint i = 0;
            i < electionId;
            i++) {
            
            /// @notice Get only public item
            if (allElections[i + 1].creator == msg.sender) {
                uint currentId = allElections[i + 1].electionId;
                Election storage currentItem = allElections[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }
        return items;
   
    }
}

