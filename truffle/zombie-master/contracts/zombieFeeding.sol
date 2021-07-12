pragma solidity ^0.5.0;

import './ZombieFactory.sol';

contract KittyInterface {
  function getKitty(uint _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {
  // address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  
  KittyInterface kittyContract;// = KittyInterface(ckAddress);

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }

  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) private {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint _newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(_species) == keccak256('kitty')) {
      _newDna = _newDna - _newDna%100 + 99;
    }
    _createZombie('NoName', _newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, 'kitty');
  }
}