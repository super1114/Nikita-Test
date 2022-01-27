// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {
    
    string public _name;
    string public _symbol;
    uint256 public _totalSupply;
    uint256 public _decimals;
    address public owner;

    mapping(address => uint256) balances;

    constructor() {
        _name = "Nikita Test Token";
        _symbol = "NTT";
        _decimals = 18;
        _totalSupply = 3 * 10**4 * 10**18; 
        balances[msg.sender] = _totalSupply;
        owner = msg.sender;
    }

    function transfer(address to, uint256 amount) external {

        require(balances[msg.sender] >= amount, "Not enough tokens");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}