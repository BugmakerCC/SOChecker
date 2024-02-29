pragma solidity ^0.8.9;
contract TaskContract {
    struct Task {
        uint id;
        string content;
        bool completed;
    }

    Task[] public tasks;

    function createTask(string memory _content) public {
        tasks.push(Task(tasks.length, _content, false));
    }

    function readAllTask() public view returns (Task[] memory) {
        return tasks;
    }

    function completeTask(uint _id) public {
        Task memory _task = tasks[_id];
        _task.completed = true;
        tasks[_id] = _task;
    }
}

