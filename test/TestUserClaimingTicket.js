var Activity = artifacts.require("Activity");

contract('Activity', function(accounts) {
  it("should have a generic activity with 10 tickets", function(){
    Activity.deployed().then(
      contract => contract.available().then(console.log)
    )
  })
});


// assert.equal(contract.available(), 10, "10 wasn't in the first account")
