pragma solidity ^0.8.9;
contract GamingAddressCollector {

    address [] addresses;

    function addAddress(address newGameAddress) public {
        addresses.push(newGameAddress);
    }

}

