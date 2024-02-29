pragma solidity ^0.4.25;
contract EIP712Signatures {
    struct Owner {
      address ownerAddress;
      uint256 sinceWhen;
    }

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    address private _owner;

    mapping (address => Owner) private _owners;

    constructor() {
        _owner = msg.sender;
        _owners[msg.sender] = Owner(_owner, block.timestamp);
    }

    modifier onlyOwner() {
        require(_owners[_owner].ownerAddress == msg.sender, "Ownership not owned by the contract");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        Owner oldOwner = _owners[_owner];
        _owners[newOwner] = Owner(newOwner, block.timestamp);
        emit OwnershipTransferred(oldOwner.ownerAddress, newOwner);
        _owner = newOwner;
    }
}

