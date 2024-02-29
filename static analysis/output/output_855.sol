pragma solidity ^0.8.9;
contract Blockbook {
    address payable public address1;
    address payable public address2;
    address payable public address3;
    address public owner;

    constructor(address payable _address1, address payable _address2, address payable _address3) public {
        address1 = _address1;
        address2 = _address2;
        address3 = _address3;
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, 'Only the contract owner can call this function');
        _;
    }

    function splitPayment() public payable {
        require(msg.value > 0, 'Payment should be greater than 0');
        uint256 amount = msg.value;
        uint256 split1 = amount * 8 / 10;
        uint256 split2 = amount / 10;
        uint256 split3 = amount / 10;

        address1.transfer(split1);
        address2.transfer(split2);
        address3.transfer(split3);
    }

    receive() external payable {
        splitPayment();
    }

    function updateAddresses(address payable _address1, address payable _address2, address payable _address3) public onlyOwner {
        address1 = _address1;
        address2 = _address2;
        address3 = _address3;
    }
}

