// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ownable {

    address public owner;    
    constructor() {
        //To init the owner
        owner = msg.sender;
    }

    //the modifier will check the caller is owner or not
    modifier onlyOwnerCanCall() {
        require(msg.sender == owner, "must be the owner");
        _;
    }

    function setOwner(address _newOwner) external onlyOwnerCanCall {
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }

    function callByOwner() external view onlyOwnerCanCall returns (bool){
        return true;
    }

    function callByAny() external pure returns (bool){
        return true;
    }
}