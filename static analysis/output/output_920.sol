pragma solidity ^0.8.9;
  abstract contract UUPSUpgradeable {

    function _upgradeTo(address target) internal virtual;
  }

