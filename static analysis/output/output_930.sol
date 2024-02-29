pragma solidity ^0.8.9;
interface Cards {
    function getCardsByOwner(address user) external view returns(uint[] memory _cards);
}

