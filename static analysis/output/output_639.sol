pragma solidity ^0.8.9;
contract ConcertTicketReservation {
    function getChoice() public returns(string memory) {
        return "Your choice";
    }
}

contract ConcertTicketReservationFactory {
    function create() public {
        ConcertTicketReservation reservationContract = new ConcertTicketReservation();
        address reservationContractAddress = address(reservationContract);
        string memory choice = reservationContract.getChoice();
    }
}

