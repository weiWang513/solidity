var contractOne = artifacts.require('ContractOne')
var contractTwo = artifacts.require('ContractTwo')
module.exports = function (deployer) {
    deployer.deploy(contractOne, contractTwo)
    // deployer.deploy(contractTwo)
} 