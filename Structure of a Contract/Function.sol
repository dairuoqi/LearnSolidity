// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


// Functions are the executable units of code. Functions are usually defined inside a contract, but they can also be defined outside of contracts.

contract SimpleFunction {
    function bid() public payable {

    }
}

// Helper function defined outside of a contract
function helper(uint x) pure returns (uint) {
    return x * 2;
}