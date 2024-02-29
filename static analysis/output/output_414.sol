// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract StudentVotes {
  Vote[] all_votes;

  struct Vote_element {
    string name;
    uint numberOfVotes;
  }

  struct Vote{
    string title;
    address creator;
    Vote_element[10] differentVotes;
    bool done;
  }

  function createVote(string memory _title , string[] memory _elements) public {
    // Before initializing the variable into a struct, you must push the struct into
    // Votes' array.
    Vote storage v = all_votes.push();
    // Then you can initialize the each variable into a struct
    v.title = _title;
    v.creator = msg.sender;
    for(uint i = 0; i < _elements.length; i++)
        v.differentVotes[i] = Vote_element(_elements[i], 0);
    v.done = false;
  }

}

