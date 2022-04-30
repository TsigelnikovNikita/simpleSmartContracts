// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Grades {
  struct Calc {
    uint amount;
    uint sum;
    uint average;
  }

  mapping (string => Calc) public results;

  function addGrade(string memory title, uint grade) public {
    require(grade > 0 && grade < 6);
    results[title].amount++;
    results[title].sum += grade;
    results[title].average = uint(results[title].sum / results[title].amount);
  }

  function getClassInformation(string memory title) public view returns (uint, uint, uint) {
    return (results[title].amount, results[title].sum, results[title].average);
  }
}
