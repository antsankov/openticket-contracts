pragma solidity ^0.4.4;

import "truffle/Assert.sol";
import "../contracts/Activity.sol";

contract TestActivity {

    function testCreateActivity(){
        Activity a = new Activity(10);

        Assert.equal(a.available(), 10, "incorrect number of tickets being instantiated");
        Assert.equal(a.claimed(), 0, "no tickets should be claimed on contract creation");
    }

    function testTwoUsersClaimingTicketsToAnActivity(){
        address r1 = 0x123;
        address r2 = 0x345;
        Activity a = new Activity(10);

        a.claim(r1, 10);

        Assert.equal(a.available(), 9, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 1, "claimed tickets did not change");
        Assert.equal(a.getTicketActiveFromAccount(r1), true, "claimed ticket is not active");
        Assert.equal(a.getTicketPriceFromAccount(r1), 10, "claimed ticket is not 10");

        Assert.equal(a.getTicketActiveFromAccount(r2), false, "r2 ");

        a.claim(r2, 20);

        Assert.equal(a.available(), 8, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 2, "claimed tickets did not change");
        Assert.equal(a.getTicketActiveFromAccount(r2), true, "claimed ticket is not active");
        Assert.equal(a.getTicketPriceFromAccount(r2), 20, "claimed ticket is not 10");

        a.deactivate(r1);

        Assert.equal(a.getTicketActiveFromAccount(r1), false, "deactivated ticket still active");
        Assert.equal(a.getTicketActiveFromAccount(r2), true, "claimed ticket is not active");
        Assert.equal(a.available(), 9, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 1, "claimed tickets did not change");

        a.deactivate(r2);
        Assert.equal(a.getTicketActiveFromAccount(r2), false, "claimed ticket is not active");
        Assert.equal(a.available(), 10, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 0, "claimed tickets did not change");
    }

    function testTradingATicket(){
        address r1 = 0x123;
        address r2 = 0x345;
        Activity a = new Activity(10);

        a.claim(r1, 10);
        a.trade(r1, r2, 20);

        Assert.equal(a.getTicketActiveFromAccount(r1), false, "giver still has ticket");
        Assert.equal(a.getTicketActiveFromAccount(r2), true, "reciver doesnt have ticket");
        Assert.equal(a.getTicketPriceFromAccount(r2), 20, "price did not change");
    }
}
