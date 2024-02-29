pragma solidity ^0.8.9;
contract Puis {
    function mint() public payable {
        require(msg.value == 1e18);
    }
}

