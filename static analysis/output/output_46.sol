pragma solidity ^0.8.9;
contract Booking_Contract {
    address recipient_address;

    address private owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner of this contract");
        _;
    }

    function set_recipient(address _recipient) external onlyOwner {
        recipient_address = _recipient;
    }

    function withdraw(address _recipient) public payable onlyOwner {
        payable(_recipient).transfer(address(this).balance);
    }
}

