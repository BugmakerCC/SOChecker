pragma solidity ^0.8.9;
contract MyContract {
    event Occupy(address _occupant, uint _value);

    enum Status {
        Vacant,
        Occupied
    }

    Status currentStatus;

    function setCurrentStatus(Status _currentStatus) external {
        currentStatus = _currentStatus;
        emit Occupy(msg.sender, uint(_currentStatus));
    }
}

