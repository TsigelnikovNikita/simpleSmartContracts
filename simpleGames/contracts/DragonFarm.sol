// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DragonFarm {
    event NewDragon(uint id, string name, uint dna);

    struct Dragon {
        uint id;
        string name;
        uint dna;
    }

    Dragon[] public dragons;
    mapping(uint => address) public DragonOwner;
    mapping(address => uint) ownerDragons;

    function GenerateRandomDna(string memory str) private pure returns(uint) {
        uint rand = uint(keccak256((abi.encode(str))));
        return rand % (10 ** 16);
    }

    function CreateDragon(string memory name) public {
        uint randDna = GenerateRandomDna(name);
        uint id = ownerDragons[msg.sender];

        dragons.push(Dragon(id, name, randDna));
        DragonOwner[id] = msg.sender;
        emit NewDragon(id, name, randDna);
        ownerDragons[msg.sender]++;
    }
}
