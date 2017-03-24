pragma solidity ^0.4.4;

contract Ticket {
    address creator;
    address public owner;
    bool public active;

    modifier onlyCreator() {
        if (msg.sender != creator) return;
        _;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) return;
        _;
    }

    modifier onlyActive() {
        if (active != true) return;
        _;
    }

    event Transfer(address indexed _from, address indexed _to);

    function Ticket() {
        creator = msg.sender;
        owner = msg.sender;
        active = true;
	  }

    function transfer(address to)
        onlyCreator
        {
            // store previous
            address prev = owner;
            // make transfer
            owner = to;
            // notify
            Transfer(prev, to);
        }

    function deactivate()
        onlyOwner
        onlyActive
        {
            active = false;
        }
}
