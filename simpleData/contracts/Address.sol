// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Address {
  mapping(uint => address) addresses;
  uint count;

  function set(address userAddress) public {
    addresses[count] = userAddress;
    count++;
  }

  function get(address userAddress) public view returns (int) {
    for (uint i = 0; i < count; i++) {
     if (addresses[i] == userAddress)
      return int(i);
    }
    return -1;
  }

  function getAll() public view returns (address[] memory) {
    address[] memory all = new address[](count);
    for (uint i = 0; i < count; i++) {
      all[i] = addresses[i];
    }
    return all;
  }
}
