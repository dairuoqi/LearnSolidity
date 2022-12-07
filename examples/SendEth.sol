// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ReceiveETH {
    
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}

/**
    1. transfer()
    2. send()
    3. call()   recommended
 */
contract SendEth {

    // 在部署时后向合约转账
    constructor() payable {}

    // 通过合约接收和转发以太币
    receive() external payable {}

    // 如果异常会转账失败，抛出异常（合约地址转账）,有gas限制，最大2300
    function transfer(address payable to, uint256 amount) external payable {
        to.transfer(amount);
    }

    // 如果异常会转账失败，仅会返回false，不会终止执行（合约地址转账）,有gas限制，最大2300
    function send(address payable to,uint256 amount) external payable {
        bool success = to.send(amount);
        require(success, "Send Failed");
    }
    
    // 如果异常会转账失败，仅会返回false，不会终止执行（调用合约的方法并转账）,没有gas限制
    function call(address payable to, uint256 amount) external payable {
        (bool success, ) = to.call{value: amount}("");
        require(success, "Call Failed");
    }

}

