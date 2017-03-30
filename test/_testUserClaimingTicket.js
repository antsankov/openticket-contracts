//To run in truffle console:
// truffle migrate
// Activity.deployed().then(contract => contract.available().then(console.log))
// Activity.deployed().then(contract => contract.claim(0x63a36c8dee46fce75cec3ddd6c04ba1cb6a3c25f).then(console.log))
// Activity.deployed().then(contract => contract.claimed().then(console.log))
// Activity.deployed().then(contract => contract.claims().valueOf().then(console.log))

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
})
