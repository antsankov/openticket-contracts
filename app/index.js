var app = require("express")();
var bodyParser = require('body-parser');
var http = require("http").Server(app);

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

var web3 = require("web3");
var provider = new web3.providers.HttpProvider("http://localhost:8545")
web3 = new web3(provider);

var contract = require("truffle-contract");
var Tx = require('ethereumjs-tx');

// Step 1: Get a contract into my application
var activity_spec = require("../build/contracts/activity.json");

// Step 2: Turn that contract into an abstraction I can use
var activity = contract(activity_spec);

// Step 3: Provision the contract with a web3 provider
activity.setProvider(provider);

// Step 4: Use the contract!
// var claimed = activity.deployed().then(
//   contract => contract.claimed().then(
//     claimed.valueOf()
// ))

app.get("/activity/claimed", function(req, res){
  res.type('text/plain');

  activity.deployed().then(
    contract => contract.claimed()
  ).then(
    claimed => res.send(claimed.valueOf()) // send text response
  )
});


app.get("/activity/available", function(req, res){
  res.type('text/plain');

  activity.deployed().then(
    contract => contract.available()
  ).then(
    available => res.send(available.valueOf()) // send text response
  )
});


app.post("/activity/claim", function(req, res) {
  var accountAddress = req.body.accountAddress
  console.log(accountAddress)
  activity.deployed().then(
    contract => contract.claim(accountAddress, 10)
  ).then(
    res.send("success") // send text response
  )
})


app.post("/transaction", function(req, res) {
  var hexTx = req.body.hexTx
  console.log( "OLD BALANCE " + web3.eth.getBalance('0x508793fb2deb0c9d10f22797bb3229e57f37ba2e'))
  web3.eth.sendRawTransaction(hexTx, function(err, hash) {
    if (!err) {
      console.log( "NEW BALANCE " + web3.eth.getBalance('0x508793fb2deb0c9d10f22797bb3229e57f37ba2e'))
      res.end("successful tx");
    }
  });
})

http.listen(8080, function(){
    console.log("listening on *:8080");
});
