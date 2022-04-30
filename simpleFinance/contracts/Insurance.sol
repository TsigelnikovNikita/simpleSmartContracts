// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Insurance {
  address payable public hospital;
  address payable public insurer;

  mapping (uint256 => Record) public all_records;
  uint256[] public records_arr;

  struct Record {
    address addr;
    uint256 ID;
    string name;
    string date;
    uint256 price;
    bool isValue;
    uint256 signatureCount;
    mapping (address => uint256) signatures;
  }

  modifier signOnly {
    require (msg.sender == hospital || msg.sender == insurer);
    _;
  }

  constructor() {
    hospital = payable(0xf809Cedc5D77D971909946A9dEA388Cf56b4CF2F);
    insurer = payable(0x78124941Bc3f6a6A55C1dF496a5eBC1BaB40e103);
  }

  event recordCreated(uint256 ID, string testName, string date, uint256 price);
  event recordSigned(uint256 ID, string testName, string date, uint256 price);

  function newRecord(uint256 ID, string memory name, string memory date, uint256 price) public {
    Record storage new_record = all_records[ID];
    require(!new_record.isValue);
    new_record.addr = msg.sender;
    new_record.ID = ID;
    new_record.name = name;
    new_record.date = date;
    new_record.price = price;
    new_record.isValue = true;
    new_record.signatureCount = 0;
    records_arr.push(ID);
    emit recordCreated(ID, name, date, price);
  }

  function signRecord(uint256 ID) signOnly public payable {
    Record storage record = all_records[ID];
    require(record.signatures[msg.sender] != 1);
    record.signatures[msg.sender] = 1;
    record.signatureCount++;
    emit recordSigned(record.ID, record.name, record.date, record.price);
    if (record.signatureCount == 2) {
      hospital.transfer(address(this).balance);
    }
  }

}
