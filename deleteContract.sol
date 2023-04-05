// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Kill {

    constructor() payable {}

    function kill() external {
        //will destroy it by itself and force send the ether to any address
        //EIP-4758: Deactivate SELFDESTRUCT
        //The SELFDESTRUCT opcode is renamed to SENDALL, and now only immediately moves all ETH in the account to the target; 
        //it no longer destroys code or storage or alters the nonce
        selfdestruct(payable(msg.sender));
    }

    //this function can not be called after the selfdestruct is executed
    function testCall() external pure returns (uint) {
        return 123;
    }
}

contract Helper {
    function getBalance() view external returns (uint){
        return address(this).balance;
    }

    //the variable _kill is a contract addtess.
    //after I call kill(), the selfdestruct will force to send ether to the msg.sender (this contract)
    function kill(Kill _kill) external {
        _kill.kill();
    }
}