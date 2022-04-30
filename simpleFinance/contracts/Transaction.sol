// SPDX-License-Identifier: MIT
pragma solidity >=0.5 <=0.8.13;

contract Transaction {
  address public owner;

  mapping (address => uint) public balances;

  event Sent(address from, address to, uint amount);

  constructor() {
    owner = msg.sender;
  }

  function coin(address receiver, uint amount) public {
    require(msg.sender == owner, "The owner cannot send coins to themself!");
    balances[receiver] += amount;
  }

  function send(address receiver, uint amount) public {
    require(amount <= balances[msg.sender], "Insufficient Funds");
    balances[msg.sender] -= amount;
    balances[receiver] += amount;
    emit Sent(msg.sender, receiver, amount);
  }
}
