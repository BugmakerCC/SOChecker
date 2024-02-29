// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.6.12;
// Contracts
pragma experimental ABIEncoderV2;

contract test{
    mapping(address => address) public managers;

    struct tokenInfo{
      address token;
      uint256 decimals;
      uint256 amount;
  }

   struct recordInfo{
       uint time;
       tokenInfo[] tokens;
   }
   
   mapping(address => mapping(uint => recordInfo)) public record_List;

    function claim(address pool, uint idRecord) public {    
        address manager = address(0);
        require(managers[pool] != manager,"claim is not manager");
        // NOTE: I retrieve a specific element from record_List mapping using pool and idRecord parameters for querying the mapping
        recordInfo storage record = record_List[pool][idRecord];
        delete record.time;
        delete record.tokens;
        record.time = block.timestamp;
        for( uint i = 0;i < 2;i++){
            uint balance;
            tokenInfo memory token; 
            token.token = address(0);
            token.amount = balance;
            token.decimals = 18;
            record.tokens.push(token);
        }
        record_List[pool][2] = record;
    }
}

