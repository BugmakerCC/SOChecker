pragma solidity ^0.8.9;
contract Puis {
    bool sent = payable(address(this)).send(msg.value);
}

