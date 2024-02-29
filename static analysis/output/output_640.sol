pragma solidity ^0.8.9;
library SafeMath {

  function safeAdd(uint256 x, uint256 y) internal pure returns (uint256 z) {
    require(x + y < 2**128, "SafeMath: overflow");

    z = x + y;
  }

  function safeSub(uint256 x, uint256 y) internal pure returns (uint256 z) {
    require(x >= y, "SafeMath: underflow");

    z = x - y;
  }
}

contract Staker {
    using SafeMath for uint256;

    mapping(uint256 => address) public staked;
    mapping(address => uint256[]) stakedByAdddress;

    event Staked(uint256 indexed tokenId, address indexed beneficiary);

    function stake(uint256[] memory tokenIds) external {
        require(msg.sender == tx.origin, "ERC1155: staking requires the origin");
        require(tokenIds.length != 0, "Staker: invalid tokenId array length");

        for(uint i = 0; i < tokenIds.length; i++) {
            uint256 tokenId = tokenIds[i];
            staked[tokenId] = msg.sender;
            stakedByAdddress[msg.sender].push(tokenId);
            emit Staked(tokenId, msg.sender);
        }
    }
}

