function getOwnersOwnedTokenIds(address owner) public view returns(uint256[] memory){
  return ownerToIds[owner];
}

pragma solidity ^0.8.0;

contract Test {

    mapping(address => uint256[]) ownerToIds;

    constructor() {
        ownerToIds[msg.sender].push(1);
        ownerToIds[msg.sender].push(2);
        ownerToIds[msg.sender].push(3);
        ownerToIds[msg.sender].push(4); 
    }

    function getOwnersOwnedTokenIds(address owner) public view returns(uint256[] memory){
        return ownerToIds[owner];
    }

}


