// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//for user to check if the object of task name is existed
library ToDoListLib {
    function find(ToDoListAdminVersion.Task[] storage _todos, string calldata specificTaskName) view internal returns (ToDoListAdminVersion.Task storage){
        for (uint i = 0; i<= _todos.length; i ++) {
            if (keccak256(abi.encodePacked(_todos[i].name)) == keccak256(abi.encodePacked(specificTaskName))){
                return _todos[i];
            }
        }
        revert("Specific ToDo Is Not Found!");
    }
}

//This version only for admin used
contract ToDoListAdminVersion {

    using ToDoListLib for Task[];

    struct Task {
        string name;
        bool completed;
    }

    address private admin;
    Task[] private tasks;

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
    function createTaskOnlyAdmin(string calldata _name) external adminOnly{
        tasks.push(Task({name: _name, completed: false}));
    }

    function updateTaskStatusOnlyAdmin(string calldata _name) external adminOnly{
        Task storage specificTask = tasks.find(_name);
        specificTask.completed = !specificTask.completed;
    }

    function getTaskByAdmin(uint taskIndex) external view adminOnly returns (Task memory){
        return tasks[taskIndex];
    }

    function kill() external adminOnly {
        selfdestruct(payable(admin));
    }
}
