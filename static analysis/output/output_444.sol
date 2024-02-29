pragma solidity ^0.4.18; 

contract lottery{
    uint public lastTicketNumber = 0;
    uint youEntredWithAmount;
    address [] public players;
    uint public entryFee =  0.01 ether;
    
    struct UserInfo {
        uint userFstTcktNumber;
        uint userLstTcktNumber;
    }
    
    mapping(address => UserInfo ) public entry;
    
    function letsdo(uint first, uint last) public{
        players.push(msg.sender);
        entry[msg.sender].userFstTcktNumber = first;
        entry[msg.sender].userLstTcktNumber = last;
    }
    
    function currentLevel(address userAddress) public constant returns (uint, uint) {
        return (entry[userAddress].userFstTcktNumber, entry[userAddress].userLstTcktNumber);
    }
    
 
      
      function numberOfParticipents() public view returns(address [] memory){
          return players;
      }
}


