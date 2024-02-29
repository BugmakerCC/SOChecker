pragma solidity 0.8.7;
contract MyContract{
    bytes8 [] Names;
    
    function setName(string memory _name) public{
        bytes8 newName=bytes8(bytes(_name));
        Names.push(newName);
    }
}

function setName(bytes8 _name) public{
        Names.push(_name);
    }


