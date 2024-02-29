pragma solidity ^0.8.9;
library Deposit {
    event DepositMade(address indexed depositor, uint depositAmount);

    struct Deposit {
        uint   depositAmount;
        address depositor;
    }
}

