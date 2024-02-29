pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MeetingCreation {

    struct Meeting {
        address meeting_creator;
        uint256 meetingID;
        string name;
        string description;
        uint256 start_date;
        uint256 end_date;
        uint256 max_tickets;
        uint256 ticket_price;
        uint256 current_tickets_sold;
        address[] attendees;
    }

    mapping(uint => Meeting) meetings;

    function RSVP (uint256 MEETINGID) public payable {
        Meeting storage m = meetings[MEETINGID];

        require(m.current_tickets_sold < m.max_tickets,
            "No more tickets available"
        );

        require(msg.sender.balance >= m.ticket_price,
            "Not enough funds"
        );

        address[] storage adr;
        adr = m.attendees;
        adr.push(msg.sender); 
        m.current_tickets_sold += 1;
    }

    function getSmartContractBalance() external view returns(uint) {
        return address(this).balance;
    }
}  


