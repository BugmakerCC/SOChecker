contract ConcertTicketReservationFactory {
    function create() public {
        ConcertTicketReservation reservationContract = new ConcertTicketReservation();

        address reservationContractAddress = address(reservationContract);

        string memory choice = reservationContract.getChoice();

    }
}


