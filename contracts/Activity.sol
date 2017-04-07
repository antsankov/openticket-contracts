pragma solidity ^0.4.4;

import "../contracts/Account.sol";

contract Activity {

    struct ticket {
      bool active;
      uint price;
    }

    mapping (address => ticket) public claims;
    uint public available;
    uint public claimed;

    function getTicketActiveFromAccount(address account) returns (bool){
      return claims[account].active;
    }

    function getTicketPriceFromAccount(address account) returns (uint){
      return claims[account].price;
    }

    modifier hasAvailable() {
        if (available == 0) return;
        _;
    }

    function Activity(uint count){
      available = count;
      claimed = 0;
    }

    event Claim(address indexed _requestor, uint _available, uint _claimed, uint _price);

    function claim(address requestor, uint price)
        hasAvailable
        {
            available -= 1;
            claimed += 1;

            claims[requestor].active = true;
            claims[requestor].price = price;

            Claim(requestor, available, claimed, price);
        }

    function deactivate(address requestor){
        if (claims[requestor].active == true) {
            claims[requestor].active = false;
            available += 1;
            claimed -= 1;
        }
    }

    function trade(address giver, address reciever, uint price){
        deactivate(giver);
        claim(reciever, price);
    }
}
