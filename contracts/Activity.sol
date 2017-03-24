pragma solidity ^0.4.4;

import "./Ticket.sol";

contract Activity {
    mapping (address => Ticket) holders;
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

    event Claim(address indexed _claimer, uint indexed _available, uint indexed _claimed);

    function claim(address claimer)
        isFull
        {
            available -= 1;
            claimed += 1;
            Ticket t = new Ticket();

            Claim(claimer, available, claimed);
        }
}
