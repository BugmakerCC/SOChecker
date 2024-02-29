pragma solidity ^0.8.0;

contract TicketBooking {
    
    struct Event {
        string name;
        string description;
        uint256 startDate;
        uint256 endDate;
        uint256 totalTickets;
        uint256 price;
        mapping (uint256 => bool) tickets;
    }
    
    Event[] public events;
    mapping (uint256 => Event) public eventMapping;
    
    address payable public admin;
    
    constructor() {
        admin = payable(msg.sender);
    }
    
    function getEvent(uint256 _id) public view returns (string memory, string memory, uint256, uint256, uint256, uint256, uint256) {
        Event storage selectedEvent = eventMapping[_id];
        uint256 availableTickets = selectedEvent.totalTickets;
        for (uint256 i = 0; i < selectedEvent.totalTickets; i++) {
            if (selectedEvent.tickets[i]) {
                availableTickets--;
            }
        }
        return (selectedEvent.name, selectedEvent.description, selectedEvent.startDate, selectedEvent.endDate, selectedEvent.totalTickets, availableTickets, selectedEvent.price);
    }
}

Event[] public events;
    mapping (uint256 => Event) public eventMapping;


