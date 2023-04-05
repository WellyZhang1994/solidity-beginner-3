// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
public - any contract and account can call
private - only inside the contract that defines the function
internal- only inside contract that inherits an internal function
external - only other contracts and accounts can call
*/
contract visibilityBase {
    uint private x = 0;
    uint internal y = 0;
    uint public z = 0;

    function privateFunction() view private returns(uint) {
        return x;
    }

    function internalFunction() view internal returns(uint){
        return y;
    }

    function publicFunction() view public returns(uint){
        return z;
    }

    function externalFunction() view external returns(uint){
        return z;
    }   

    function example() view external returns(uint){
        //can not call external function inside the contract
        //if we want to call external function, need to use "this" keyword to call it.
        this.externalFunction(); // not recommend (gas inefficient)
        return x + y + z;
    }

}

contract visibilityChild is visibilityBase {
    function example2() external {
        //can not access private variable from visibilityBase
        //x += 1;
        y = y + z;
        
        //can not call external function in child contract
        //externalFunction();
        internalFunction();
        publicFunction();
    }
}