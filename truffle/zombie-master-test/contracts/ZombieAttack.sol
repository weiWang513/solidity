pragma solidity >=0.4.21 <=0.6.0;

import './zombiehelper.sol';

contract ZombieAttack is ZombieHelper {
  uint randNonce = 0;

  uint attackVictoryProbability = 70;

  function randomMod(uint _modulus) internal returns(uint) {
    randNonce+=1;
    return uint (keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  }
  //
  function attack (uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];

    uint _random = randomMod(100);

    if (_random <= attackVictoryProbability) {
      myZombie.winCount.add(1);//+=1;
      myZombie.level.add(1); // +=1;
      enemyZombie.lossCount.add(1);//+=1;
      feedAndMultiply(_zombieId, _targetId, 'zombie');
    } else {
      myZombie.lossCount.add(1); //+=1;
      enemyZombie.winCount.add(1); //+=1;
      _triggerCoolDown(myZombie);
    }
  }
}