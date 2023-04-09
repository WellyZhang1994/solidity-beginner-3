// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


//This version is gas sensitive version
contract ToDoListForUser {

    struct Task {
        //transfer from string to bytes16 
        bytes16 name;
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
    function createTask(bytes16 _name) external {
        //use userTasks[msg.sender] directly (76742 -> 76727)
        //Task[] storage _task = userTasks[msg.sender]; 
        userTasks[msg.sender].push(Task({name: _name, completed: false}));
    }

    function updateTaskStatus(uint taskIndex) external {
        //use index to update the status (34464 -> 33923)
        //Task[] storage _task = userTasks[msg.sender];
        //Task storage specificTask = _task.find(_name);
        //specificTask.completed = !specificTask.completed;
        userTasks[msg.sender][taskIndex].completed = !userTasks[msg.sender][taskIndex].completed;
    }

    function getTaskById(uint taskIndex) external view returns (Task memory){
        Task[] storage _task = userTasks[msg.sender];
        return _task[taskIndex];
    }

    //only admin can delete the contract
    function kill() external adminOnly {
        selfdestruct(payable(admin));
    }
}