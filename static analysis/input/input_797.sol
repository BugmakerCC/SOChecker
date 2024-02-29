pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract ToDoList {
    ...
   mapping(address => Task[]) public tasks;

    event AddTask(address indexed creator, uint256 indexed id, string description);

    function addTask(string memory _description) public {
        uint256 id = uint256(
            keccak256(abi.encodePacked(msg.sender, _description))
        );

        tasks[msg.sender].push(
            Task({id: id, description: _description, completed: false})
        );

        emit AddTask(msg.sender,id,_description);
    }

...
}



