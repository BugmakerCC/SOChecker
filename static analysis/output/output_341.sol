pragma solidity ^0.8.9;
contract MyContract {
    struct People {
        uint256 FavouriteNumber;
        string name;
    }

    People public person = People({FavouriteNumber: 2, name: "MB"});
}

