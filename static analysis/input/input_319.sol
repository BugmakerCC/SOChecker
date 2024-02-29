
function bookroom(uint256 _index) public payable uptofee{
            payable(owner).transfer(msg.value);
            roomstatus = Status.Occupied;
            bookertoroom[msg.sender] = hotelroomsarray[_index];
            bookertoroomTostatusofroom[roomstatus][msg.sender] = 
               hotelroomsarray[_index];        
        }


