pragma solidity ^0.8.9;
contract FavoriteNumber {
    uint256 private favoriteNumber;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function getFavoriteNumber() public view returns (uint256) {
        return favoriteNumber;
    }
}

