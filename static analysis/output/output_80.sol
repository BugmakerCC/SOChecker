pragma solidity ^0.8;

contract MyContract {
    function isMsgSenderAddressThis() public view returns (bool) {
        return msg.sender == address(this);
    }
    
    function yes() external view returns (bool) {
        // makes an external call to itself
        // same as MyContract(address(this)).isMsgSenderAddressThis()
        return this.isMsgSenderAddressThis();
    }

    function nope() external view returns (bool) {
        // this is an internal call, so it returns false
        return isMsgSenderAddressThis();
    }
}

