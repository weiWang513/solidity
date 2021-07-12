pragma solidity ^0.5.0;
import 'truffle/Assert.sol';
import 'truffle/DeployedAddresses.sol';
contract TestAdoption {
  Adoption adoption = Adoption(DeployedAddresses.Adoption());
  
}