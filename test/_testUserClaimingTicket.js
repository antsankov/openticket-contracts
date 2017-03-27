//To run in truffle console:
// truffle migrate
// Activity.deployed().then(contract => contract.available().then(console.log))
// Activity.deployed().then(contract => contract.claim(ADDRESS).then(console.log))
// Activity.deployed().then(contract => contract.claimed().then(console.log))

var Activity = artifacts.require("Activity");

contract('Activity', function(accounts) {
  it("deployed activity should have 10 tickets available", function(){
    Activity.deployed().then(
      contract => contract.available()
    ).then(
      available => assert.equal(available.valueOf(), 10, "10 tickets aren't available")
    )
  });
  it("deployed activity should have 0 tickets claimed", function(){
    Activity.deployed().then(
      contract => contract.claimed()
    ).then(
      claimed => assert.equal(claimed.valueOf(), 0, "no tickets should be claimed yet")
    )
  });

  // TEST FAILS
  it("claim a ticket should affect activity state", function(){
    Activity.deployed().then( instance => {
      before = instance.contract.available()
      console.log(before)
      instance.claim(accounts[1])
      after = instance.contract.available()
      console.log(after)
      assert.notEqual(before, 56, "nothing changed")
    }).then(
      instance => contract.available()
    ).then(
      available => assert.equal(available.valueOf(), 120, "10 tickets aren't available")
    )
  });
})
