pragma solidity >=0.4.21 <=0.6.0;

import './ownable.sol';

import './SafeMath.sol';

contract ZombieFactory is Ownable{
  using SafeMath for uint256;
  using SafeMath16 for uint16;
  using SafeMath32 for uint32;
  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;

  uint cooldownTime = 1 days;

  struct Zombie {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  }

  event NewZombie(uint zombieId, string name, uint dna);

  Zombie[] public zombies;

  mapping (uint=>address) public zombieToOwner;

  mapping (address=>uint) ownerZombieCount;

  function _createZombie(string memory _name, uint _dna, uint32 _level, uint32 _readyTime, uint16 _winCount, uint16 _lossCount) internal {
    uint _id = zombies.push(Zombie(_name, _dna, _level, _readyTime, _winCount, _lossCount)) - 1;
    zombieToOwner[_id] = msg.sender;
    ownerZombieCount[msg.sender].add(1);// += 1;
    emit NewZombie(_id, _name, _dna);
  }

  function _generateRandomDna (string memory _str) private view returns (uint) {
    uint _dna = uint(keccak256(abi.encodePacked(_str)));
    return _dna % dnaModulus;
  }

  function createRandomZombie(string memory _name) public {
    require(ownerZombieCount[msg.sender] == 0);
    uint randomDna = _generateRandomDna(_name);
    _createZombie(_name, randomDna, 1, uint32(now + cooldownTime), 0, 0);
  }
}