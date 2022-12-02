// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./IERC20.sol";
import "./IERC20Metadata.sol";

contract ERC20 is IERC20, IERC20Metadata {

    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    // All two of these values are immutable: they can only be set once during construction
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }
    
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view virtual override returns (uint256) {
        return _balances[_owner];
    }
    /**
    * Requirements:
    * - `_to` cannot be the zero address.
    * - the caller must have a balance of at least `_value`.
    */
    function transfer(address _to ,uint256 _value) public virtual override returns (bool) {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view virtual override returns (uint256) {
       return _allowances[_owner][_spender];
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        _approve(msg.sender, _spender, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public  virtual override returns (bool) {
        _spendAllowance(_from, _to, _value);
        _transfer(_from, _to, _value);
        return true;
    }


    function _transfer(address _from, address _to, uint256 _value) internal virtual {
        require(_from != address(0), "ERC20: transfer from the zero address");
        require(_to != address(0), "ERC20: transfer to the zero address");
        uint fromBalance = _balances[_from];
        require(fromBalance >= _value, "ERC20: transfer amount exceeds balance");
        _balances[_from] = fromBalance - _value;
        _balances[_to] += _value;
        emit Transfer(_from, _to, _value);
    }


    function _approve (address _owner, address _spender, uint256 _value) internal virtual {
        require(_owner != address(0), "ERC20: approve from the zero address");
        require(_spender != address(0), "ERC20: approve to the zero address");
        _allowances[_owner][_spender] = _value;
        emit Approval(_owner, _spender, _value);
    }
    
    function _spendAllowance(address _owner, address _spender, uint256 _value) internal virtual{
        uint256 currentAllowance = allowance(_owner, _spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= _value, "ERC20: insufficient allowance");
            _approve(_owner, _spender, _value);
        }
    }
}