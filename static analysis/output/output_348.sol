pragma solidity ^0.8.9;
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

    mapping (string => uint256) nameToTicketLevel;

    function getTicketLevel(string memory _name) public view returns (uint256) {
        return nameToTicketLevel[_name];
    }

    constructor() {
        nameToTicketLevel["bronze"] = 3;
        nameToTicketLevel["silver"] = 10;
        nameToTicketLevel["gold"] = 50;
        nameToTicketLevel["platinum"] = 100;
    }
}

