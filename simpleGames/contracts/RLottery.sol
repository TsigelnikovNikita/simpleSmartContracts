// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RLottery {
  struct player {
    string name;
  }
  uint private constant maxPlayers = 10;
  uint private num;
  mapping (uint => player) public players;

  function getTickets(string memory name) public returns(string memory, uint) {
    require(num <= maxPlayers, "There are already 10 players in the lottery!");
    num++;
    players[num] = player(name);
    return ("Your ticket is ",num);
  }

  function Winner() public view returns(string memory, string memory, string memory, uint) {
    uint ticket;
    uint randomNumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, num))) % (num - 1);
    randomNumber++;
    ticket = randomNumber % num;
    return ("The winner name is ", players[ticket].name, "The winner ticket is ", ticket);
  }
}
