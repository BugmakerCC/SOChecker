address payable public winner;
function selectWinner() public {
}
...

function showWinner() public returns(bool) {
      return winner.transfer(getMoney());
}

contract Lottery{
    address public manager;
    address payable[] public participants; 
    address payable selectedWinner;

    constructor(){
        manager = msg.sender;   
    }

    receive() external payable{       
        require(msg.value == 1 ether);
        participants.push(payable(msg.sender));
    } 

    function getMoney() public view returns(uint){
        require(msg.sender == manager);
        return address(this).balance;
    }

    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }
   
    function selectWinner() public{
        require(msg.sender == manager);
        require(participants.length >= 3);
        uint r = random();


        uint index = r % participants.length;

        selectedWinner = participants[index];
        selectedWinner.transfer(getMoney());   
    }

    function showWinner() public view returns(address){
         return selectedWinner;
    }
}


