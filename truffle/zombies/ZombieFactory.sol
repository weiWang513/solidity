pragma solidity ^0.4.19;
import './Ownable';
contract ZombieFactory is Ownable {
  event NewZombie(uint zombieId, string name, uint dna);

  uint myUsignedInteger = 100;
  uint dnaDigits = 16;
  uint dnaModules = 10 ** dnaDigits;
  uint coolDownTime = 1 days;
  struct Zombie {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  }
  Zombie[] public zombies;

  mapping (uint => address) public zombieToOwner;
  mapping (address=>uint) ownerZombieCount;

  function _createZombie(string _name, uint _dna) internal {
    uint _id = zombies.push(Zombie(_name, _dna, 1, uint32 (now + coolDownTime)), 0, 0) - 1;
    zombieToOwner[_id] = msg.sender;
    ownerZombieCount[msg.sender] += 1;
    NewZombie(_id, _name, _dna);
  }
  function _multiply(uint a, uint b) private pure returns (uint) {
    return a * b;
  }
  function sayHello() public view returns (string) {

  }
  function _generateRandomDna(string _str) private view returns (uint) {
    uint _dna = keccak256(_str);
    return _dna % dnaModules;
  }
  function createRandomZombie(string _str) public {
    require(ownerZombieCount[msg.sender] == 0);
    uint _dna = _generateRandomDna(_str);
    _createZombie(_str, _dna);
  }

}