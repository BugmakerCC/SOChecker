pragma solidity ^0.8.0;

contract test{
    mapping(address=> mapping(uint => uint)) public address_id_liked;

    function register(uint id) external{ 
        address_id_liked[msg.sender][id] = 1;
    }

    function test_(uint index) external view returns(uint) {
        uint out = address_id_liked[msg.sender][index];
        return(out);
    }

    function ops(uint id, uint num) external {
        address_id_liked[msg.sender][id] = num;
    }
}


