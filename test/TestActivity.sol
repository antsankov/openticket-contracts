pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "../contracts/Activity.sol";

contract TestActivity {

    function testCreateActivity(){
        Activity a = new Activity(10);

        Assert.equal(a.available(), 10, "incorrect number of tickets being instantiated.");
        Assert.equal(a.claimed(), 0, "no tickets should be claimed on contract creation.");
    }

    function testClaimingATicket(){
        address claimer = 0x123;
        Activity a = new Activity(10);

        a.claim(claimer);

        Assert.equal(a.available(), 9, "avaialble tickets did not change");
        Assert.equal(a.claimed(), 1, "claimed tickets did not change");
    }

}
