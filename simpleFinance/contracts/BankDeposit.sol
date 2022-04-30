// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./SafeMath.sol";

contract BankDeposit {
  using SafeMath for uint;

  mapping(address => uint) public userDeposit;
  mapping(address => uint) public balance;
  mapping(address => uint) public time;
  mapping(address => uint) public percentWithdraw;
  mapping(address => uint) public allPercentWithdraw;
  uint public stepTime = 0.05 hours;

  event Invest(address investor, uint256 amount);
  event Withdraw(address investor, uint256 amount);

  modifier userExists() {
    require(balance[msg.sender] > 0, "Client isn't found");
    _;
  }

  modifier checkTime() {
    require(block.timestamp >= time[msg.sender].add(stepTime), "Too fast withdraw request");
    _;
  }

  function bankAccount() public payable {
    require(msg.value >= 0.001 ether);
  }

  function collectPercent() userExists checkTime public {
    if (balance[msg.sender].mul(2) <= allPercentWithdraw[msg.sender]) {
      balance[msg.sender] = 0;
      time[msg.sender] = 0;
      percentWithdraw[msg.sender] = 0;
    } else {
      uint payout = payoutAmount();
      allPercentWithdraw[msg.sender] = percentWithdraw[msg.sender].add(payout);
      payable(msg.sender).transfer(payout);
      emit Withdraw(msg.sender, payout);
    }
  }

  function deposit() public payable {
    if (msg.value > 0) {
      if (balance[msg.sender] > 0 && block.timestamp > time[msg.sender].add(stepTime)) {
        collectPercent();
        percentWithdraw[msg.sender] = 0;
      }
      balance[msg.sender] = balance[msg.sender].add(msg.value);
      time[msg.sender] = block.timestamp;
      emit Invest(msg.sender, msg.value);
    }
  }

  function percentRate() public view returns(uint) {
    if (balance[msg.sender] < 10 ether) {
      return (5);
    }
    else if (balance[msg.sender] >= 10 && balance[msg.sender] < 20 ether) {
      return (7);
    }
    else if (balance[msg.sender] >= 20 && balance[msg.sender] < 30 ether) {
      return (8);
    }
    else {
      return (7);
    }
  }

  function payoutAmount() public view returns(uint256) {
    uint percent = percentRate();
    uint different = block.timestamp.sub(time[msg.sender]).div(stepTime);
    uint rate = balance[msg.sender].div(100).mul(percent);
    uint withdrawalAmount = rate.mul(different).sub(percentWithdraw[msg.sender]);
    return withdrawalAmount;
  }

  function returnDeposit() public {
    uint withdrawalAmount = balance[msg.sender];
    balance[msg.sender] = 0;
    time[msg.sender] = 0;
    percentWithdraw[msg.sender] = 0;
    payable(msg.sender).transfer(withdrawalAmount);
  }
}
