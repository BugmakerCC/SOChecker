pragma solidity ^0.8.9;
  interface IMultiCall {

    function multiCall(
      address[] calldata targets,
      bytes[] calldata encodedFunctions
    ) external payable returns (bytes[] memory);

  }

  interface ITimeLock {

    function grant(
      bytes32 roleNameOrAddress, 
      address toRole
    ) external;

    function grantRole(
      bytes32 roleNameOrAddress, 
      address toRole
    ) external;

    function hasRole(
      bytes32 roleNameOrAddress
    ) external view returns (bool);

    function renounceRole(
      bytes32 roleNameOrAddress
    ) external;

  }

  interface IERC20 {

    function transfer(
      address to,
      uint256 value
    ) external returns (bool);

    function approve(
      address spender,
      uint256 value
    ) external returns (bool);

    function transferFrom(
      address from,
      address to,
      uint256 value
    ) external returns (bool);

    event Transfer(
      address indexed from,
      address indexed to,
      uint256 value
    );

    event Approval(
      address indexed owner,
      address indexed spender,
      uint256 value
    );
  }

