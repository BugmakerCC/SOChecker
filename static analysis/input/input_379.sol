    constructor(){
        require(owner == msg.sender);  
        owner = msg.sender;
    }


