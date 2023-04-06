// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FunctionModifier {

    uint public x = 10;
    bool public paused;

    function setPaused(bool _paused) external {
        paused = _paused;
    }

    //basic
    modifier whenNotPaused() {
        require(paused == false, "Can not be paused!");
        // Underscore is a special character only used inside a function modifier and it tells Solidity to execute the rest of the code.
        _;
    }

    //with input
    modifier checkInput(uint _y) {
        require( _y >= 100, "x must be greater than 100");
        _;
    }

    //sandwitch 
    modifier sandwitch() {
        //x + 1 before executed the function
        x += 1;
        _;
        //x ** 2 after executed the function
        x *= 2;
    }

    //basic function modifier
    //It's something like middleware can be triggered before executed the function.
    function add() external whenNotPaused returns(uint){
        return x += 1;
    }
    
    //with parameter check
    function addWithNumber(uint y) view external whenNotPaused checkInput(y) returns(uint){
        return x + y;
    }

    //sandwitch mode
    function sandwitchIcre()  external sandwitch returns(uint){
        return x;
    }
}