var NoteContracts = artifacts.require('../contracts/NoteContracts.sol');

module.exports = function (deployer) {
  deployer.deploy(NoteContracts);
}