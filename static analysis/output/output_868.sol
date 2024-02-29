// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {
    struct Stake {
        uint256 tokenId;
        uint256 lockPeriod;
        uint256 startDate;
        address owner;
    }
   
    mapping(uint256 => Stake) public vault; 

    function loadData(uint256 tokenId, uint256 lockPeriod, uint256 startDate, address owner) public {
        Stake memory newStake = Stake(tokenId, lockPeriod, startDate, owner);
        vault[tokenId] = newStake;
    }
    
    function getNftInfo(uint256[] calldata tokenIdsInput) public view returns (uint256[] memory tokenIdsReturn,
        uint256[] memory lockPeriodsReturn,
        uint256[] memory startDatesReturn,
        address[] memory ownersReturn){
      uint256 tokenId;
      uint256[] memory tokenIds = new uint256[](tokenIdsInput.length);
      uint256[] memory lockPeriods = new uint256[](tokenIdsInput.length);
      uint256[] memory startDates = new uint256[](tokenIdsInput.length);
      address[] memory owners = new address[](tokenIdsInput.length);
      for (uint i = 0; i < tokenIdsInput.length; i++) {
          tokenId = tokenIdsInput[i];
          Stake storage staked = vault[tokenId];
          tokenIds[i] = staked.tokenId;
          lockPeriods[i] = staked.lockPeriod;
          startDates[i] = staked.startDate;
          owners[i] = staked.owner;
      }

      return (tokenIds,
        lockPeriods,
        startDates,
        owners);
  }
}

