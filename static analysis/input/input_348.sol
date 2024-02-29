mapping (string => uint256) nameToTicketLevel;

pragma solidity ^0.8.8;

contract LevelUp {

    struct Customers {
        string name;
        uint256 level;
    }
    mapping (address => Customers) customers;

    function addCustomer(string memory _name, uint256 _ticketLevel) public {
        customers[msg.sender] = Customers(_name, _ticketLevel);
    }

    function levelUp(string memory _name) public {
        customers[msg.sender].level++;
    }

}


