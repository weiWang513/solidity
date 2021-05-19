var HDWalletProvider = require("truffle-hdwallet-provider");
// 12-word mnemonic
var mnemonic = "opinion destroy betray add minus plus div times function class number string";
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    develop: {
      port: 8545
    },
    ropsten: {
      provider: () => 
          new HDWalletProvider(mnemonic, "https://ropsten.infura.io/v3/YOUR-PROJECT-ID"),
      network_id: 3 // official id of the ropsten network
    }
  }
};
