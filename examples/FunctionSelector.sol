// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract FunctionSelector {
    //params: "transfer(address,uint256)", uint 必须用uint256代表 => 0xa9059cbb
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }

}

contract Receiver {

    event Log(bytes data, address indexed _to, uint _amount);

    //params:  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,111
    function transfer(address _to, uint _amount) external {
        // 呼叫一个函数得数据由两部分组成，第一部分是函数选择器(函数签名),第二部分是函数得参数
        // 函数得签名实际上是通过函数得名称和它的参数得类型打包在一起进行hash，取hash得前4位16进制
        emit Log(msg.data, _to, _amount);
        // 0xa9059cbb
        // 000000000000000000000000ab8483f64d9c6d1ecf9b849ae677dd3315835cb2
        // 000000000000000000000000000000000000000000000000000000000000006f
    }
}

