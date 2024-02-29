address payable private owner;

constructor(){
        owner = payable(msg.sender);
    }


