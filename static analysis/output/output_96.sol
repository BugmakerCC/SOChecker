pragma solidity ^0.8.9;
contract favorite {

    uint256 public favoriteNumber;
   
    constructor () {
        favoriteNumber = uint256(513);
    }

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

}

