// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
Errors allow you to define descriptive names and data for failure situations.
Errors can be used in revert statements. In comparison to string descriptions, errors are much cheaper and allow you to encode additional data.
*/
contract Token {
    mapping(address => uint) balances;

    error BalanceNotEnough(uint requested, uint available);
    function transfer(address to, uint amount) public {
        uint balance = balances[msg.sender];
        if (balance < amount) {
            revert BalanceNotEnough(amount, balance);
        }
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}