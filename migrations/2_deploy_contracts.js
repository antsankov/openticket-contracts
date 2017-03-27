var Activity = artifacts.require("./Activity.sol");
var Ticket = artifacts.require("./Ticket.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(Ticket);
  deployer.link(Ticket, Activity)
  deployer.deploy(Activity, 10);
};
