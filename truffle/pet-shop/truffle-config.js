// module.exports = {
//   // See <http://truffleframework.com/docs/advanced/configuration>
//   // for more about customizing your Truffle configuration!
//   networks: {
//     development: {
//       host: "127.0.0.1",
//       port: 7545,
//       network_id: "*" // Match any network id
//     },
//     develop: {
//       port: 8545
//     }
//   }
// };

var HDWalletProvider = require('truffle-hdwallet-provider') // 导入模块
var mnemonic =
  'boring tank focus sock anger nature suit stick extend garment pilot situate' //MetaMask的助记词。

module.exports = {
  networks: {
    ropsten: {
      provider: function () {
        // mnemonic表示MetaMask的助记词。 "ropsten.infura.io/v3/33..."表示Infura上的项目id
        return new HDWalletProvider(
          mnemonic,
          'https://ropsten.infura.io/v3/3fc53bea793b42aaa42dedf68d19f046',
          0
        ) // 1表示第二个账户(从0开始)
      },
      network_id: '*', // match any network
      gas: 3012388,
      gasPrice: 30000000000,
    },
  },
}
