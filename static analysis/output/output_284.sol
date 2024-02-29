pragma solidity ^0.8.7;

contract SimpleStorage {

    uint256 favoriteNumber;
    bool favoriteBool;

    struct People
    {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;

        function store(uint256 _favoriteNumber) public {
            favoriteNumber =_favoriteNumber;
        }
    }
  

