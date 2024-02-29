pragma solidity ^0.6.12;
    abstract contract Ownable {
        address public owner;

        event OwnershipTransferred(address indexed previousOwner);

        constructor () public {
            owner = msg.sender;
        }

        modifier restricted() {
            require(msg.sender == owner);
            _;
        }
        function transferOwnership(address newOwner) public restricted {
            if (newOwner != address(0)) {
                owner = newOwner;
            }
        }
    }

