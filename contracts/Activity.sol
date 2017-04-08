pragma solidity ^0.4.4;

contract Activity {

    struct ticket {
      bool active;
    }

    mapping (address => ticket) public claims;
    uint public available;
    uint public claimed;

    function getTicketActiveFromAccount(address account) returns (bool){
      return claims[account].active;
    }

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

    function trade(address giver, address reciever){
        deactivate(giver);
        claim(reciever);
    }
}
