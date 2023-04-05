// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ForLoops {

    function loop() external pure{
        // for loop
        // *important:  the more loop run, the more gas used
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                // Skip to next iteration
                continue;
            }
            if (i == 5) {
                // Exit loop with break
                break;
            }
        }

        // while loop
        uint j;
        // while (condition)
        while (j < 10) {
            j++;
        }
    }
}