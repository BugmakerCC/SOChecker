pragma solidity ^0.8.9;
contract SimpleStorage {
    uint256 public count;
    mapping(uint256 => bool) public usedIndexes;

    function store(uint256 number) public 
    {
        require(
            uint256(count) <= 61,
            "Maximum number of items reached"
        );

        uint lastIndex = count;
        for(int i=0; i < 62; i++ ) 
        {
          usedIndexes[lastIndex] = true;
          lastIndex += 1;
        }
        count = lastIndex;
    }
}

