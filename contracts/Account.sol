pragma solidity ^0.4.4;

contract Account {

  uint public balance;
  string hardwareId;

  function Account(string id){
    hardwareId = id;
    balance = 0;
  }

  function deposit(uint amount){
    balance += amount;
  }

  function withdraw(uint amount){
    if (amount > balance){
      balance -= amount;
    }
  }
}
