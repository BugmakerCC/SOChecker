pragma solidity ^0.8.9;
contract CommissionWallet {
    address public commissionWallet;

    constructor (address admin, address payable recipient) {
        commissionWallet = recipient;
    }
}

