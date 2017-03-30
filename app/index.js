var app = require("express")();
var http = require("http").Server(app);

var web3 = require("web3");
var contract = require("truffle-contract");

// Step 1: Get a contract into my application
var activity_spec = require("../build/contracts/activity.json");

// Step 2: Turn that contract into an abstraction I can use
var activity = contract(activity_spec);

// Step 3: Provision the contract with a web3 provider
activity.setProvider(new web3.providers.HttpProvider("http://localhost:8545"));

// Step 4: Use the contract!
// var claimed = activity.deployed().then(
//   contract => contract.claimed().then(
//     claimed.valueOf()
// ))

app.get("/concert/claimed", function(req, res){
  res.type('text/plain');

  activity.deployed().then(
    contract => contract.claimed()
  ).then(
    claimed => res.send(claimed.valueOf()) // send text response
  )
});

app.get("/concert/available", function(req, res){
  res.type('text/plain');

  activity.deployed().then(
    contract => contract.available()
  ).then(
    available => res.send(available.valueOf()) // send text response
  )
});



http.listen(8080, function(){
    console.log("listening on *:8080");
});
