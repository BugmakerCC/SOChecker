pragma solidity ^0.8.9;
interface DAOFactory {

    function DAO_Create(
        address[] calldata newDAO_Addresses,
        address[] calldata newDAO_TreasuryAccounts,
        bytes[] calldata newDAO_AdminAccounts,
        bytes[] calldata newDAO_AdminAccounts_Role,
        address[] calldata newDAO_Owners
    )
    external
    returns (
        bytes[] memory
    );
}

interface DailyFactory {

    function DAO_Create(
        address[] calldata newDAO_Addresses,
        address[] calldata newDAO_TreasuryAccounts,
        bytes[] calldata newDAO_AdminAccounts,
        bytes[] calldata newDAO_AdminAccounts_Role,
        address[] calldata newDAO_Owners
    )
    external
    returns (
        bytes[] memory
    );

    function registerParticipantFor(
        uint256 _participantID,
        address _participant
    )
    external;

    function getParticipants()
    external
    view
    returns (uint256[] memory participantIDs_array);

    function getParticipant(
        uint256 _participantID
    )
    external
    view
    returns (uint256 winnerID);
}

