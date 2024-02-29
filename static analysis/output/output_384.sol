pragma solidity ^0.8.9;
contract Test {
    constructor(address payable _owner) {
        _transfer(msg.sender, _owner, 0);
    }

    function test() public pure virtual {
    }

    function _transfer(address from, address to, uint256 _amount) internal virtual {
        (bool success, ) = from.call{value: _amount}(new bytes(0));
        require(success, "transfer failed");
    }
}

