pragma solidity >=0.4.21 <=0.6.0;

contract Owned{
  address public owner;
  constructor() public {
    owner = msg.sender;
  }
  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }
  function transferOwnerShip(address newOwner) onlyOwner public {
    owner = newOwner;
  }
}