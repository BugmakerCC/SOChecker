    mapping (uint => address) players;
    uint playersCount=0;

function enter() public payable {    
            playersCount++;
            players[playersCount]=payable(msg.sender);       
        }               
           

       function pickWinner() public onlyowner returns (address payable) {
            require(address(this).balance>0,"Please upload balance");
            uint index = getRandomNumber() % playersCount;
            address payable winner=payable(players[index]);
            
            lotteryHistory[lotteryId] = winner;
            lotteryId++;
    
            for (uint i=0; i< playersCount ; i++) {
                 delete players[i];
            }     
            return winner   ;   
        }

   lotteryId => playersCount => address

  1 => playersCount => address

 2 => playersCount => address

function enter() public payable {    
            playersCount++;
            players[lotteryId][playersCount]=msg.sender;       
        }         


