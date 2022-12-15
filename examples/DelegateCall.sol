// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


/**
    有一种特殊类型的消息调用，被称为 委托调用(delegatecall) 。
    它和一般的消息调用的区别在于，目标地址的代码将在发起调用的合约的上下文中执行，并且 msg.sender 和 msg.value 不变。 
    这意味着一个合约可以在运行时从另外一个地址动态加载代码。存储、当前地址和余额都指向发起调用的合约，只有代码是从被调用地址获取的。
    这使得 Solidity 可以实现”库“能力：可复用的代码库可以放在一个合约的存储上，如用来实现复杂的数据结构的库。
 */
contract DelegateCall {

    // 变量的顺序需要和被调用的合约的顺序保持一致
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _addr, uint _num) external payable {
        // _test.delegatecall(
        //     abi.encodeWithSignature("setVars(uint256)", _num)
        // );
        (bool success, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success, "delegatecall failed");
    }
}

contract TestDelegateCall {

    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}