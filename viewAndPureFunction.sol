// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ViewAndPure {
    uint public x = 1;

    // Promise not to modify the state.
    // The view function only read the data from the storage (state variable)
    function addToX(uint y) public view returns (uint) {
        return x + y;
    }

    // Promise not to modify or read from the state.
    // Can not use any state variable both of input and output.
    function add(uint i, uint j) public pure returns (uint) {
        return i + j;
    }
}