pragma solidity ^0.5.0;
import './Ownable.sol';
contract ZombieFactory is Ownable {
  event NewZombie(uint zombieId, string name, uint dna);
  // 记录僵尸所有者
  mapping (uint=>address) public zombieToOwner;
  // 记录玩家账户中僵尸数量
  mapping (address=>uint) ownerZombieCount;

  uint dnaDigits = 16;
  uint dnaModulus = 10**dnaDigits;

  uint cooldownTime = 1 days;


  struct Zombie {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
  }

  Zombie[] public zombies;

  function _createZombie(string _name, uint _dna) internal {
    uint _id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1;
    zombieToOwner[_id] = msg.sender;
    ownerZombieCount[msg.sender]++;
    NewZombie(_id, _name, _dna);
  }

  function _generateRandomDna(string _str) private view returns(uint) {
    uint _rand = keccak256(_str);
    return _rand % dnaModulus;
  }

  function createRandomZombie(string _name) {
    require(ownerZombieCount[msg.sender] == 0);
    uint _dna = _generateRandomDna(_name);
    _createZombie(_name, _dna);
  }
}