pragma solidity ^0.8.0;

contract Lottery {

    address[] public s_players;

    function enterLottery(uint tickets) public payable returns (address[] memory) {

        uint lotteryCost = _tickets * 25 ether / 100;
        address sender = msg.sender;
        require(msg.value >= lotteryCost, 'Ticket cant be purchased');

        for (uint x = 0; x < _tickets; x++){
            s_players.push(payable(sender));
            
        }
        
        return s_players;
    }

}


