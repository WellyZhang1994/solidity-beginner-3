// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Immutable {
    // Gas: 386
    // Immutable variable can fix the value and also save the gas;
    // Can only be assigned when the contract deployed
    address public immutable OWNER;
    // Gas: 2533 
    address public notImmutableOwner;
    constructor() {
        OWNER = msg.sender;
    }

    function getOwner() view external returns (address) {
        return OWNER;
    }
}