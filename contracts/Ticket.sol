pragma solidity ^0.4.4;

contract Ticket {
    address public owner;
    bool public active;

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
        owner = msg.sender;
        active = true;
	}

    function transfer(address to)
        onlyOwner
        {
            // store previous
            address prev = owner;
            // make transfer
            owner = to;
            // notify
            Transfer(prev, to);
        }

    function use()
        onlyOwner
        onlyActive
        {
            active = false;
        }
}
