// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract MyCoin {
  address owner;
  string name;
  string symbol;
  uint256 totalCoins;

  function Coin() public {
    owner = msg.sender;
    name = "MyCoin";
    symbol = "MYC";
    totalCoins = 1000;
    balance[owner] = totalCoins;
  }

  mapping (address => uint256) public balance;

  function totalSupply() view public returns (uint256) {
    return totalCoins;
  }

  function balanceOf(address addr) view public returns (uint256) {
    return balance[addr];
  }

  function transfer(address to, uint256 value) public returns (bool) {
    if (balance[msg.sender] < value)
      return false;
    address from = msg.sender;
    emit Transfer(from, to, value);
    balance[to] = balance[to] + value;
    balance[from] = balance[from] - value;
    return true;
  }

  event Transfer(address indexed from, address indexed to, uint256 value);
}
