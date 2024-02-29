pragma solidity ^0.8.9;
contract Owners {

    address[] public owners;

    constructor (address[] memory temp) {
        for (uint i=0; i< temp.length; i++) {
            owners.push(temp[i]);
        }
    }


}

