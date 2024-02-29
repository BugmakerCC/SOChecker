pragma solidity ^0.8.9;
    interface IERC20 {
      
      function allowance(address owner, address spender) external view returns (uint256);

      
      function transfer(address to, uint256 value) external;

      
      function approve(address spender, uint256 value) external;

      
      function transferFrom(
        address from,
        address to,
        uint256 value
      ) external returns (bool);

      
      function totalSupply() external view returns (uint256);
    }

