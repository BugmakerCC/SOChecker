 require(msg.sender==minter)

    address public _minter;


    constructor(address minter_){
        _minter=minter_;        
     }


