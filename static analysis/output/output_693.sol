pragma solidity ^0.4.25;
contract TasksStore {
    struct tasksStruct {
        string name;
        uint start;
        bool is_done;
    }
    
    tasksStruct[] public tasks;
    
    function add_task(string memory _name) public {
        tasksStruct memory newTask = tasksStruct(_name, uint32(now), false);
        tasks.push(newTask);
    }
    
    function show_opened_tasks() public view returns (uint) {
        uint count_of_opened_tasks = 0;
        for (uint i=0; i<tasks.length; i++){
            if (!tasks[i].is_done) {
                count_of_opened_tasks += 1; 
            }
        }
        
        return count_of_opened_tasks;
    }
}

