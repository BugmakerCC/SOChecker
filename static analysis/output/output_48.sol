pragma solidity ^0.8.9;
contract KeeperCompatible {
    modifier onlyKeepers() {
        require(msg.sender == keeper(), 'Only Keepers allowed');
        _;
    }

    function keeper() public view returns (address) {
        revert('No keeper available');
    }
}

