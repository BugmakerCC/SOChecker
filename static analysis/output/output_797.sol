pragma solidity ^0.8.9;
contract ToDoList {
    event AddTask(address indexed creator, uint256 indexed id, string description);

    struct Task {
        uint256 id;
        string description;
        bool completed;
    }

    mapping(address => Task[]) public tasks;

    function addTask(string memory _description) public {
        uint256 id = uint256(
            keccak256(abi.encodePacked(msg.sender, _description))
        );

        tasks[msg.sender].push(
            Task({id: id, description: _description, completed: false})
        );

        emit AddTask(msg.sender,id,_description);
    }
}

