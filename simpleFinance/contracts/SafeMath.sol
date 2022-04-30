// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns(uint256) {
    if (a == 0)
      return 0;
    uint256 res = a * b;
    assert(res / a == b);
    return res;
  }

  function div(uint256 a, uint256 b) internal pure returns(uint256) {
    return a / b;
  }

  function sub(uint256 a, uint256 b) internal pure returns(uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns(uint256) {
    uint256 res = a + b;
    assert(res >= a);
    return res;
  }
}
