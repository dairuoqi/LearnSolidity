// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Enum {

    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }

    Status public status;

    function get() public view returns(Status) {
        return status;
    }
    function set(Status _status) external {
        status = _status;
    }
    function ship() external {
        status = Status.Shipped;
    }
    function reset() external {
        delete status;
    }
}