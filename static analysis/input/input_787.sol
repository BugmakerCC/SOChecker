         function bookroom1() public payable uptofee{                  
            require(booked.isOccupied == false, "This room is alraeady occupied");              
            payable(owner).transfer(msg.value); 
            hotelroomsarray[0].isOccupied = true;                          
            bookertoroom[msg.sender] = hotelroomsarray[0];
            bookers.push(msg.sender);       
            addrtoamntpaid[msg.sender] = msg.value; 
            count++;                
        }


