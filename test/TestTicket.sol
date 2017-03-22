pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Ticket.sol";

contract TestTicket {

    function testCreatorIsInitialOwner() {
        Ticket t = new Ticket();
        Assert.equal(t.owner(), address(this), "creator is not initial owner");
        Assert.equal(t.active(), true, "ticket is not initially active");
    }

    function testTransfer() {
        address newOwner = 0x123;

        Ticket t = new Ticket();
        t.transfer(newOwner);

        Assert.equal(t.owner(), newOwner, "owner is not equal to new owner");
        Assert.notEqual(t.owner(), address(this), "previous owner is still owner");
        Assert.equal(t.active(), true, "ticket should still be active after transfer");
    }

    function testUseNonOwner() {
        Ticket t = new Ticket();
        address otherUser = 0x123;
        t.transfer(otherUser);

        t.use();
        Assert.equal(t.active(), true, "non-owner cannot use ticket");
    }

    function testUseAsOwner() {
        Ticket t = new Ticket();
        t.use();
        Assert.equal(t.active(), false, "using ticket as owner did not set active to false");
    }
}
