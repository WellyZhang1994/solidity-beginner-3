// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract AccessControl {

    //call the event to log the grant or revoke action;
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    //role -> account -> bool
    //the role will be stored in bytes32 bacause it is a hash rather than a string
    mapping(bytes32 => mapping(address => bool)) public roles;

    //Hash: 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //Hash: 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    //to check the caller is admin or not
    //Can use ADMIN or USER role for this modifier
    modifier onlyAdminRoleCanCall(bytes32 _role){
        require(roles[_role][msg.sender] == true, "Must be admin can call this functino");
        _;
    }

    //init the admin for contact deployer
    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    //onlyAdminRoleCanCall(ADMIN) means user should be an admin than call this function
    function grantRole(bytes32 _role, address _account) external onlyAdminRoleCanCall(ADMIN) {
        _grantRole(_role, _account);
    }

    function revokeRole(bytes32 _role, address _account) external onlyAdminRoleCanCall(ADMIN) {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }
}