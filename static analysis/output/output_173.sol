pragma solidity ^0.8.9;
contract GameRoom {
    struct Room {
        address[] players;
        uint256 score;
        uint256 time;
    }
    
    Room[] public rooms;
    
    function createRoom() public {
        Room memory room = Room(new address[](0), 0, 0);
        rooms.push(room);
    }
    
    function joinRoom(uint256 roomIndex) public {
        require(roomIndex < rooms.length, "Room does not exist");
        rooms[roomIndex].players.push(msg.sender);
    }
    
    function addPlayer(uint256 roomIndex, address player) public {
        require(roomIndex < rooms.length, "Room does not exist");
        rooms[roomIndex].players.push(player);
    }
}

