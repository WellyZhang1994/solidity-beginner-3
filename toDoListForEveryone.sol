// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//for user to check if the object of task name is existed
library ToDoListLib {
    function find(ToDoListForUser.Task[] storage _todos, string calldata specificTaskName) view internal returns (ToDoListForUser.Task storage){
        for (uint i = 0; i<= _todos.length; i ++) {
            if (keccak256(abi.encodePacked(_todos[i].name)) == keccak256(abi.encodePacked(specificTaskName))){
                return _todos[i];
            }
        }
        revert("Specific ToDo Is Not Found!");
    }
}

//This version for everyone use
contract ToDoListForUser {

    using ToDoListLib for Task[];

    struct Task {
        string name;
        bool completed;
    }

    address private admin;
    mapping(address => Task[]) userTasks;

    //set the admin as deployer
    constructor() {
        admin = msg.sender;
    }

    //make a modifier to do the authorizaion
    modifier adminOnly {
        require(msg.sender == admin);
        _;
    }

    //default complete status should be false
    function createTask(string calldata _name) external {
        Task[] storage _task = userTasks[msg.sender];
        _task.push(Task({name: _name, completed: false}));
    }

    function updateTaskStatus(string calldata _name) external {
        Task[] storage _task = userTasks[msg.sender];
        Task storage specificTask = _task.find(_name);
        specificTask.completed = !specificTask.completed;
    }

    function getTaskById(uint taskIndex) external view  returns (Task memory){
        Task[] storage _task = userTasks[msg.sender];
        return _task[taskIndex];
    }

    //only admin can delete the contract 
    function kill() external adminOnly {
        selfdestruct(payable(admin));
    }
}