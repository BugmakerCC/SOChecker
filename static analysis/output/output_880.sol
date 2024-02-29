pragma solidity ^0.8.9;
contract SimpleStorage {
    bool HasFavoriteNumber = true;
    uint256 public FavoriteNumber;
    uint256 public testVar;

    function store(uint256 _FavoriteNumber) public {
        FavoriteNumber = _FavoriteNumber;
        testVar += 5;
    }

    function retrieve() public view returns (uint256) {   
        return FavoriteNumber;
    }
}

