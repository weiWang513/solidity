const LotteryCoin = artifacts.require("LotteryCoin");
const LotteryShop = artifacts.require("LotteryShop");

module.exports = function(deployer) {
  deployer.deploy(LotteryCoin).then(function() {
    return deployer.deploy(LotteryShop, LotteryCoin.address);
  });
};
