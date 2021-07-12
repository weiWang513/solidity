const ConvertLib = artifacts.require("ConvertLib");
const MetaCoin = artifacts.require("MetaCoin");
const Voting = artifacts.require("Voting");
const Words = artifacts.require("Words");
const Words = artifacts.require("Words");
const Words = artifacts.require("Words");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(Voting, [web3.utils.utf8ToHex('test1'), web3.utils.utf8ToHex('test2'), web3.utils.utf8ToHex('test3')]);
  deployer.deploy(Words);
};
