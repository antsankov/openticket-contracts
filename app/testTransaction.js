// testrpc --account="0xdeadbeef08acf422fe2c836a2d3d597b77717be1656398c07afa7cb17c11b5a4, 100000000000000000000",  --account="0x1111111108acf422fe2c836a2d3d597b77717be1656398c07afa7cb17c11b5a4, 200000000000000000000"
// deadbeef = 100 ether
// 11111111 = 200 ether

var web3 = require("web3");
var Tx = require('ethereumjs-tx');

web3 = new web3(new web3.providers.HttpProvider("http://localhost:8545"));

console.log( "deafault balance" + web3.eth.getBalance('2035ef58098b871c69ecf381126bf6ed63215155')) //from deadbeef

var privateKey = new Buffer('deadbeef08acf422fe2c836a2d3d597b77717be1656398c07afa7cb17c11b5a4', 'hex')

var rawTx = {
  nonce: '0x00',
  gasPrice: '0x08184e72a000',
  gas: '0x6208', //21,000
  to: '0x508793fb2deb0c9d10f22797bb3229e57f37ba2e', // second account
  value: '0x1BC16D674EC80000', // 2 ether
}

var tx = new Tx(rawTx);
tx.sign(privateKey);

// This is what gets encoded in the qr code
var serializedTx = tx.serialize();
console.log(serializedTx.toString('hex'))

// What gets run by the usher
console.log( "OLD BALANCE " + web3.eth.getBalance('0x508793fb2deb0c9d10f22797bb3229e57f37ba2e'))

web3.eth.sendRawTransaction(serializedTx.toString('hex'), function(err, hash) {
  if (!err)
    console.log(hash);
    console.log( "NEW BALANCE " + web3.eth.getBalance('0x508793fb2deb0c9d10f22797bb3229e57f37ba2e'))
});
