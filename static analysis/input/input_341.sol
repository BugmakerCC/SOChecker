pragma solidity ^0.8;

contract MyContract {
    struct People {
        uint256 FavouriteNumber;
        string name;
    }

    People public person = People({FavouriteNumber: 2, name: "MB"});
}

uint256 number = uint8(100); 
bytes b = "hello"; 


