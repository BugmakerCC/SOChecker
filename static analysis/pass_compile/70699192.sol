pragma solidity ^0.8.6;
contract mycontract{

    address owner;
    string name;
    bool visible;
    uint16 count;

constructor () {
    owner=msg.sender;    
}

    function changname (string memory _name) public returns (string memory){
        if(msg.sender==owner){
            name=_name;
            return "sucsesss";
        }else{
            return "acsess denid";
        }
    }

    function showname () view public returns(string memory){
        return name;
    }
}

