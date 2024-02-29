pragma solidity ^0.8.9;
contract Ownable {
    address payable _owner = payable(owner());

    modifier onlyOwner() {
        if (_owner != msg.sender) {
            revert();
        }
        _;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        _owner = payable(newOwner);
    }
}

