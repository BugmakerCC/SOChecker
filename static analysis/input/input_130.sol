
 pragma solidity >=0.6.0;

 import "./1_Storage.sol";

 contract StorageFactory {

      function createsimplestoragecontract() public {
           Storage _simplestorage = new Storage();
      }

 }


