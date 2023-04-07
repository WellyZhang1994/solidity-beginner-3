// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ToDoList {

    struct Task {
        string name;
        bool completed;
    }

    address private admin;
    Task[] public tasks;

    constructor() {
        admin = msg.sender;
    }

    modifier adminOnly {
        require(msg.sender == admin);
        _;
    }

    function createTaskOnlyAdmin(string calldata _name, bool _completed) external adminOnly{
        tasks.push(Task({name: _name, completed: _completed}));
    }

    function updateTaskOnlyAdmin(string calldata _name) external adminOnly{
    }
}
