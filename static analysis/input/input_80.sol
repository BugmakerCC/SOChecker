pragma solidity ^0.8;

contract MyContract {
    function isMsgSenderAddressThis() public view returns (bool) {
        return msg.sender == address(this);
    }
    
    function yes() external view returns (bool) {
        return this.isMsgSenderAddressThis();
    }

    function nope() external view returns (bool) {
        return isMsgSenderAddressThis();
    }
}


