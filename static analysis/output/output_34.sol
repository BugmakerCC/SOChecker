pragma solidity ^0.8.9;
interface IAccount {

  function balanceOf(address account) external view returns(uint256);
  function ownerOf(address account) external view returns(address);

  function transfer(address to, uint256 value) external;
}

interface IPresido {
  function getPresido(address account) external view returns(address);
}

interface ISelfDestructing {
  function selfDestruct(address beneficiary) external;
}

