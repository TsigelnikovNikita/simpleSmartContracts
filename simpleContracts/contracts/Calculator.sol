// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Calculator {
  function getCalk(int256 x, bytes32 oper, int256 y) public pure returns (int256) {
    if (oper == '+')
      return x + y;
    if (oper == '-')
      return x - y;
    if (oper == '*')
      return x * y;
    if (oper == '/')
      return x / y;
    return -1;
  }
}
