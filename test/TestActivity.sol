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

        a.claim(r1);

        Assert.equal(a.available(), 9, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 1, "claimed tickets did not change");
        Assert.equal(a.claims(r1), true, "claimed ticket is not active");
        Assert.equal(a.claims(r2), false, "r2 ");

        a.claim(r2);

        Assert.equal(a.available(), 8, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 2, "claimed tickets did not change");
        Assert.equal(a.claims(r2), true, "claimed ticket is not active");

        a.deactivate(r1);

        Assert.equal(a.claims(r1), false, "deactivated ticket still active");
        Assert.equal(a.claims(r2), true, "claimed ticket is not active");
        Assert.equal(a.available(), 9, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 1, "claimed tickets did not change");

        a.deactivate(r2);
        Assert.equal(a.claims(r1), false, "deactivated ticket still active");
        Assert.equal(a.claims(r2), false, "claimed ticket is not active");
        Assert.equal(a.available(), 10, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 0, "claimed tickets did not change");
    }

    function testTradingATicket(){
        address r1 = 0x123;
        address r2 = 0x345;
        Activity a = new Activity(10);

        a.claim(r1);
        a.trade(r1, r2);

        Assert.equal(a.claims(r1), false, "giver still has ticket");
        Assert.equal(a.claims(r2), true, "reciver doesnt have ticket");
    }
}
