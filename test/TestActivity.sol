pragma solidity ^0.4.2;

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
        Assert.notEqual(a.claims(r1), 0, "ticket not claimed in mapping");

        a.claim(r2);

        Assert.equal(a.available(), 8, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 2, "claimed tickets did not change");
        Assert.notEqual(a.claims(r2), 0, "ticket not claimed in mapping");
    }
}
