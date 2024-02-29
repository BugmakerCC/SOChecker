pragma solidity ^0.8.11;

contract lottery
{
  address manager;
    address payable[]  public players;


  function setManager() public{
      manager = msg.sender;
  }
  function enterLottery () public payable{
    require(msg.value > 0.9 ether);
    players.push(payable(msg.sender)); 
  }
function random() private view returns(uint){
    return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp)));   
  }

  function winner() public payable{
      uint index = random() % players.length;
    players[index].transfer(address(this).balance);
    players = new address payable[](0);

  }
}


