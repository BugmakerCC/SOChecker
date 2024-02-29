pragma solidity ^0.8.9;
contract Lock {

    event DataStoredNonAnonymous(address admin, uint256 indexed data);
    event DataStoredAnonymous(address admin, uint256 indexed data) anonymous;
   
    uint256 x;
    uint256 y;
   
    function storeDataNonAnonymous(uint256 _data) external {
      x = _data;
      emit DataStoredNonAnonymous(msg.sender, _data);
    }

    function storeDataAnonymous(uint256 _data) external {
      y = _data;
      emit DataStoredAnonymous(msg.sender, _data);
    }

}

