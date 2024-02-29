pragma solidity ^0.8;

contract MyContract {
    enum Status {
        Vacant,
        Occupied
    }

    Status currentStatus;

    function setCurrentStatus(Status _currentStatus) external {
        currentStatus = _currentStatus;
    }

    function getCurrentStatusVerbose() external view returns (string memory) {
        if (currentStatus == Status.Vacant) {
            return "The current status is Vacant";
        } else if (currentStatus == Status.Occupied) {
            return "The current status is Occupied";
        }
    }
}

pragma solidity ^0.8;

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

myContract.on('Occupy', async (event) => {
    updateOccupancyInExternalDB(event);
});


