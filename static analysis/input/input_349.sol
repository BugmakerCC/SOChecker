pragma solidity ^0.8.7;

contract PickWinner {
    address payable[] players;
    function pickWinner() public {
        uint256 winnerIndex = 80 % players.length; 
        players[winnerIndex].transfer(address(this).balance); 
    }
}


