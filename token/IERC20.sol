// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


// details : https://eips.ethereum.org/EIPS/eip-20

interface IERC20 {

    //Returns the total token supply.
    function totalSupply() external view returns (uint256);

    //Returns the account balance of another account with address _owner.
    function balanceOf(address _owner) external view returns (uint256);

    //Transfers _value amount of tokens to address _to, and MUST fire the Transfer event. The function SHOULD throw if the message caller’s account balance does not have enough tokens to spend.
    //Note Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event.
    function transfer(address _to ,uint256 _value) external returns (bool);

    // Returns the amount which _spender is still allowed to withdraw from _owner.
    function allowance(address _owner, address _spender) external view returns (uint256);

    // Allows _spender to withdraw from your account multiple times, up to the _value amount. If this function is called again it overwrites the current allowance with _value.
    function approve(address _spender, uint256 _value) external returns (bool);
    /*
    Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event.
    The transferFrom method is used for a withdraw workflow, allowing contracts to transfer tokens on your behalf. This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies. The function SHOULD throw unless the _from account has deliberately authorized the sender of the message via some mechanism.
    Note Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event.
    */

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool);
    // MUST trigger when tokens are transferred, including zero value transfers.
    // A token contract which creates new tokens SHOULD trigger a Transfer event with the _from address set to 0x0 when tokens are created.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // MUST trigger on any successful call to approve(address _spender, uint256 _value).
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}