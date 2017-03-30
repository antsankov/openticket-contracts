pragma solidity ^0.4.4;

import "./Ticket.sol";

contract Activity {

    struct test_ticket {
      bool active;
    }

    // map between address of claiment, and address of ticket.
    mapping (address => test_ticket) public claims;
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

    event Claim(address indexed _requestor, uint _available, uint _claimed);

    function claim(address requestor)
        hasAvailable
        {
            available -= 1;
            claimed += 1;
            claims[requestor].active = true;

            Claim(requestor, available, claimed);
        }

    function deactivate(address requestor){
        if (claims[requestor].active == true) {
            claims[requestor].active = false;
            available += 1;
            claimed -= 1;
        }
    }
}
