// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Split {
  event Sent(address from, address[] to, uint amount);

  address public owner;
  mapping (address => uint) public balances;

  constructor () {
    owner = msg.sender;
  }

  function coin(address receiver, uint amount) public {
    require(msg.sender == owner, "The owner cannot send coins to themself!");
    balances[receiver] += amount;
  }

  function Send(uint amount, address[] memory receivers) public {
    require(amount <= balances[msg.sender], "Insufficient funds");
    balances[msg.sender] -= amount;
    for (uint i; i < receivers.length; i++) {
      balances[receivers[i]] += amount / receivers.length;
    }
    emit Sent(msg.sender, receivers, amount);
  }
}
