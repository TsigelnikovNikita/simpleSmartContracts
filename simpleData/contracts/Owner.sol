// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Owner {
  address owner;

  struct user {
    string name;
    uint number;
    uint age;
  }

  mapping(string => user) public users;

  constructor() {
    owner = msg.sender;
  }

  function setUser(string memory name, uint number, uint age) public {
    require(msg.sender == owner, "Not an owner");
    users[name] = user(name, number, age);
  }

  function getUser(string memory name) public view returns(bool, string memory, uint, uint) {
    require(msg.sender == owner, "Not an owner");
    return (msg.sender == owner, users[name].name, users[name].number, users[name].age);
  }
}
