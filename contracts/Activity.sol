pragma solidity ^0.4.4;

import "./Ticket.sol";

contract Activity {
    // map between address of claiment, and address of ticket.
    mapping (address => address) public claims;
    uint public available;
    uint public claimed;

    modifier hasAvailable() {
        if (available == 0) return;
        _;
    }

    function Activity(uint count){
      available = count;
      claimed = 0;
    }

    event Claim(address indexed _requestor, uint indexed _available, uint indexed _claimed);

    function claim(address requestor)
        hasAvailable
        {
            available -= 1;
            claimed += 1;
            Ticket t = new Ticket(requestor);

            claims[requestor] = address(t);

            Claim(requestor, available, claimed);
        }
}
