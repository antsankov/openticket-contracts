pragma solidity ^0.4.4;

import "./Ticket.sol";

contract Activity {
    mapping (address => Ticket) claims;
    uint public available;
    uint public claimed;

    modifier isFull() {
        if (available == 0) return;
        _;
    }

    function Activity(uint count){
      available = count;
      claimed = 0;
    }

    event Claim(address indexed _requestor, uint indexed _available, uint indexed _claimed);

    function claim(address requestor)
        isFull
        {
            available -= 1;
            claimed += 1;
            Ticket t = new Ticket();

            Claim(requestor, available, claimed);
        }
}
