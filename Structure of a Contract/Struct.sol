// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// Structs are custom defined types that can group several variables.

contract Ballot {
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }
}