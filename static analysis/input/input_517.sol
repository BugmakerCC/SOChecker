address payable private owner;
constructor(){
   owner=payable(msg.sender)
}

function withdraw() public {
       require(msg.sender==owner,"only contract owner can call this");
       owner.transfer(address(this).balance);
    }

function withdraw() public {
           require(msg.sender==owner,"only contract owner can call this");
           (bool success, ) = owner.call{value:address(this).balance}("");
           require(success,"Withdraw failed")
        }


