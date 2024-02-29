pragma solidity ^0.8.9;
contract Transfer {
    address public owner;
    address public addressToTransfer;
    uint256 public amount;

    constructor(address _owner) public {
        owner = _owner;
    }

    function transfer(address _addressToTransfer) public payable {
        require(msg.sender == owner, "Only owner can call this function.");
        addressToTransfer = _addressToTransfer;
        amount = address(this).balance;
        (bool success, ) = addressToTransfer.call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }
}

