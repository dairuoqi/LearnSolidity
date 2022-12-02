// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
 1. 状态变量
 2. 局部变量
 3. 全局变量
 */


contract Variables {
    // 状态变量 : 会被真实存储在链上
    uint public num = 123;
    
    function doSomething() public {
        // 局部变量 : 不会被保存在链上
        uint i = 456;
        // 全局变量
        uint timestamp = block.timestamp;
        address sender = msg.sender;
    }

}