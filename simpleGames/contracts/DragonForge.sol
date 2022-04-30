// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DragonFarm.sol";
contract DragonForge is DragonFarm {
  function Reforge(string memory name, uint id, uint food) public payable {
    require(msg.value > 0, "Pay for food!");
    uint brain = uint(keccak256(abi.encode(food)));
    brain = brain % (10 ** 16);
    uint newDna = (id + brain) / 2;
    dragons.push(Dragon(id, name, newDna));
  }
}
