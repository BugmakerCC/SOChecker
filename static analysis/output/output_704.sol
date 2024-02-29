pragma solidity ^0.8.9;
contract t1 {
    mapping(address => uint256[]) AllSpecialNFT;
    function addNewVal(address _off, uint _tokenId) public {
        AllSpecialNFT[_off].push(_tokenId);
    }
    function findSize(address _off) public view returns(uint){
        return AllSpecialNFT[_off].length;
    }
    
}

contract t2 {
    t1 _t1;
    constructor(t1 t1_ ){
        _t1 = t1_;
    }
    
    function callandAdd(uint _tokenId) public{
        _t1.addNewVal(msg.sender,_tokenId);
    }
    
    
}

