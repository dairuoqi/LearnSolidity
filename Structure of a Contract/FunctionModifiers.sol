// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
Function modifiers can be used to amend the semantics of functions in a declarative way.
Overloading, that is, having the same modifier name with different parameters, is not possible.
Like functions, modifiers can be overridden.
*/
contract FunctionModifier{

    bool public paused;
    uint public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    modifier check() {
       require(!paused, "paused");
       _;
    }

    function inc() external check{
        count += 1;
    }

    function dec() external check{
        count -= 1;
    }

}