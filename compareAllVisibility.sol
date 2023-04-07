// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
function visibility
public - any contract and account can call
private - only inside the contract that defines the function
internal- only inside contract that inherits an internal function
external - only other contracts and accounts can call
*/

contract visibilityBase {

    //state variable doesn't have the external visibility
    uint private privateData = 0;
    uint internal internalData = 0;
    uint public publicData = 0;

    //using underscore to present the private function
    //internal used only
    function _privateFunction(uint input) view private returns(uint) {
        return input + privateData;
    }

    //can call by current contract and inherited(child) contract.
    function internalFunction(uint fromChild) view internal returns(uint){
        //can call private function
        return _privateFunction(fromChild);
    }

    //can call by both of current contract, inherited contract and external address.
    function publicFunction(uint fromAnyWhere) view public returns(uint){
        return fromAnyWhere + publicData;
    }

    //can only call by external address.
    function externalFunction() view external returns(uint){
        return publicData;
    }   

    function example() view external returns(uint){
        //can not call external function inside the contract
        //if we want to call external function, need to use "this" keyword to call it.
        this.externalFunction(); // not recommend (gas inefficient)
        return privateData + internalData + publicData;
    }

}

contract visibilityChild is visibilityBase {
    function example2() view external {
        //Function state mutability can be restricted to view
        //Because we need to get the state variable for calculation, we should add "view" keyword.
        //Why we need add "view" or "pure" to identity the action of each function?
        //ref: https://ethereum.stackexchange.com/questions/30486/why-is-it-important-to-declare-functions-as-view-or-pure-in-solidity
        //That could be useful for determining things like if your node syncs using the light sync option whether or not to get a chainstate update from a full node.

        //Both of view and pure type don't cost any gas to call if they're called externally from outside the contract (but they do cost gas if called internally by another function).


        //can not access private variable from visibilityBase
        //x += 1;
        uint temp = internalData + publicData;
        
        //can not call external function in child contract
        //externalFunction();
        internalFunction(temp);
        publicFunction(temp);
    }
}
