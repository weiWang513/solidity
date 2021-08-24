pragma solidity >=0.4.21 <=0.6.0;

import './ZombieFactory.sol';

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
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

  KittyInterface kittyInterface;// = KittyInterface(ckAddress);

  modifier onlyOwnerOf(uint _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    _;
  }

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyInterface = KittyInterface(_address);
  }

  function feedAndMultiply (uint _zombieId, uint _targetDna, string memory _species) internal onlyOwnerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie));
    uint newDna = _targetDna % dnaModulus;
    uint _dna = (myZombie.dna.add(newDna)).div(2);// / 2;
    if(keccak256('kitty') == keccak256(abi.encodePacked(_species))) {
      _dna = _dna.sub(_dna%100).add(99); // - _dna % 100 + 99;
    }
    _createZombie('', _dna, 1, uint32(now + cooldownTime), 0, 0);
    _triggerCoolDown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyInterface.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, 'kitty');
  }

  function _triggerCoolDown (Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Zombie storage _zombie) internal returns(bool) {
    return (_zombie.readyTime <= now);
  }
}