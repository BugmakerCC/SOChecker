pragma solidity ^0.8.9;
abstract contract OwnedBy {
    address private _owner;

    constructor (address _owner) {
        _owner = _owner;
    }

    modifier onlyOwner {
        require(_owner == msg.sender, "OwnedBy: caller is not the owner");
        _;
    }

    function owner() external view returns (address) {
        return _owner;
    }
 }

 abstract contract ApproveForAll {
    function isApprovedForAll(address owner, address spender) internal view virtual returns (bool);
 }

