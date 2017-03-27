pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Ticket.sol";

contract TestTicket {

    function testCreatorIsInitialOwner() {
        Ticket t = new Ticket(address(this));
        Assert.equal(t.owner(), address(this), "creator is not initial owner");
        Assert.equal(t.active(), true, "ticket is not initially active");
    }

    function testTransfer() {
        address newOwner = 0x123;

        Ticket t = new Ticket(address(this));
        t.transfer(newOwner);

        Assert.equal(t.owner(), newOwner, "owner is not equal to new owner");
        Assert.notEqual(t.owner(), address(this), "previous owner is still owner");
        Assert.equal(t.active(), true, "ticket should still be active after transfer");
    }


    function testReturnTicket() {
        address newOwner = 0x123;
        address originalOwner = address(this);

        Ticket t = new Ticket(originalOwner);

        t.transfer(newOwner);

        Assert.equal(t.owner(), newOwner, "owner is not equal to new owner");
        Assert.notEqual(t.owner(), originalOwner, "previous owner is still owner");

        t.transfer(originalOwner);

        Assert.equal(t.owner(), originalOwner, "original owner did not get ticket back");
        Assert.notEqual(t.owner(), newOwner, "previous owner is still owner");
    }

    function testDeactivateNonOwner() {
        Ticket t = new Ticket(address(this));
        address otherDeactivater = 0x123;
        t.transfer(otherDeactivater);

        t.deactivate();
        Assert.equal(t.active(), true, "non-owner cannot deactivate ticket");
    }

    function testDeactivateAsOwner() {
        Ticket t = new Ticket(address(this));
        t.deactivate();
        Assert.equal(t.active(), false, "using ticket as owner did not set active to false");
    }
}
