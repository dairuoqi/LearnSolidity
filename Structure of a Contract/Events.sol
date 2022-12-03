// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SimpaleContract {

    event Log(string message);

    function log(string memory text) external {
       emit Log(text);
    }

}