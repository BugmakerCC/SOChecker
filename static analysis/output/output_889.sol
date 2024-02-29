pragma solidity ^0.8.9;
contract Response {
    struct Infos {
        uint _id;
        address _add;
    }
    
    mapping(uint=>Infos) public infos;
    
    function getInfo(uint _infoid) external view returns (uint, address) {
         return (infos[_infoid]._id, infos[_infoid]._add);
    }
}

