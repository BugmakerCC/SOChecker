pragma solidity ^0.4.25;
contract UserStructs {
    
    mapping (address => UserStruct) userAddressToStruct;
    
    struct UserStruct {
        address contractAddress;
        string name;
        string symbol;
        uint256 decimals;
    }

    constructor() {
        address contractAddress = msg.sender;
        UserStruct userStruct;
        userStruct.contractAddress = contractAddress;
        userStruct.name = "CryptoMoonCoin";
        userStruct.symbol = "CMC";
        userStruct.decimals = 2;
        userAddressToStruct[contractAddress] = userStruct;
    }
}

