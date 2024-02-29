function getTodo(string memory _name, uint _age) external pure returns(Todo memory) {
        Todo memory myTodo = Todo(_name, _age);
        return myTodo;
}

pragma solidity ^0.8.0;

contract Test {
    
    struct Todo {
        string name;
        uint age;
    }

    Todo[] todoArray;

    function createTodo(string memory _name, uint _age) public {
        todoArray.push(Todo(_name, _age));
    }

    function getTodo(uint _index) external view returns(Todo memory) {
        return todoArray[_index];
    }
} 


