// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./ERC20.sol";

contract WR is ERC20 {

    constructor(uint _totalSupply) ERC20("RockToWeb3","RTW3") {
        _mint(msg.sender, _totalSupply);
    }

}