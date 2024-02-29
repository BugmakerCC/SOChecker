pragma solidity ^0.8.9;
contract StorageFactory {

     function createsimplestoragecontract() public {
          Storage _simplestorage = new Storage();
     }

 }

contract Storage {

    address public owner;

    constructor() public {
       owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

}

