// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Dice {
  address public manager;
  address payable[] public players;

  modifier onlyManager() {
    require(manager == msg.sender, "Access denied");
    _;
  }

  constructor() {
    manager = msg.sender;
  }
  function CEO() public {
    manager = msg.sender;
  }

  function Enter() public payable {
    require(msg.value > .001 ether, "The bet is too small!");
    players.push(payable(msg.sender));
  }

  function getRandomNumber(uint number) public view returns (uint) {
    uint cast = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, number))) % 10;
    return (cast + 2);
  }

  function Winner() public payable restricted returns(string memory, uint, uint) {
    uint player1 = getRandomNumber(0);
    uint player2 = getRandomNumber(1);

    if (player1 > player2) {
      players[0].transfer(address(this).balance);
      return ("Player1 is winner", player1, player2);
    }
    else if (player1 < player2) {
      players[1].transfer(address(this).balance);
      return ("Player2 is winner", player1, player2);
    }
    else
      return ("draw", player1, player2);
  }

  modifier restricted() {
    require(msg.sender == manager, "Not access");
    _;
  }
}
