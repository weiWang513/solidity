const ERC721 = artifacts.require("ERC721");
const Ownable = artifacts.require("Ownable");
const safemath = artifacts.require("safemath");
const zombieattack = artifacts.require("zombieattack");
const ZombieFactory = artifacts.require("ZombieFactory");
const ZombieFeeding = artifacts.require("ZombieFeeding");
const zombieHelper = artifacts.require("zombieHelper");
const ZombieOwnerShip = artifacts.require("ZombieOwnerShip");

module.exports = function(deployer) {
  // deployer.deploy(ERC721, Ownable, safemath, zombieattack, ZombieFactory, ZombieFeeding, zombieHelper, ZombieOwnerShip);
  deployer.deploy(ZombieOwnerShip);
  // deployer.link(ConvertLib, MetaCoin);
  // deployer.deploy(MetaCoin);
};
