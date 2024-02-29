pragma solidity ^0.8.9;
contract Records {
    struct Record {
        address user;
        uint256 timestamp;
        string title;
        string description;
        uint256 amount;
    }

    mapping(uint => Record[]) recordsByUserID;

    Record[] public records;

    event Approved(uint indexed userId, uint indexed recordId);

    constructor() public {
        recordsByUserID[0].push(Record(msg.sender, block.timestamp, "Test Record 1", "This is the first record on the network", 1000));
        recordsByUserID[1].push(
            Record(msg.sender, block.timestamp, "Test Record 2", "This is the second record on the network", 1000)
        );
        recordsByUserID[2].push(
            Record(msg.sender, block.timestamp, "Test Record 3", "This is the third record on the network", 1000)
        );
    }

    function approve(uint userId, uint recordId) external {
        recordsByUserID[userId].push(
            Record(msg.sender, block.timestamp, "Test Record 4", "This is the fourth record on the network", 1000)
        );
        emit Approved(userId, recordId);
    }
}

