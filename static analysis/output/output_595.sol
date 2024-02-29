pragma solidity ^0.8.9;
contract test {
       struct Info {
        uint a;
        uint b;
        uint[] data;
    }
    
    mapping(address => Info) private infos;
    
    function set() public {
        infos[msg.sender].a = 1;
        infos[msg.sender].b = 2;
        infos[msg.sender].data.push(3);
    }
    
    function get() private view{
      infos[msg.sender].a; 
      infos[msg.sender].b; 
      infos[msg.sender].data[0]; 
    } }

