pragma solidity ^0.4.19;
import './ZombieFeeding';
contract ZombieHelper is ZombieFeeding{

  uint levelUpFee = 0.01 ether;

  modifier abovelevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  function withDraw() external onlyOwner {
    owner.transfer(this.balance);
  }

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function levelUp(uint _zombieId) external payable {
    require(msg.value >= levelUpFee);
    zombies[_zombieId].level.add(1);
  }

  function changeName(uint _zombieId, string _newName) external abovelevel(2, _zombieId) onlyOwnerOf(_zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombieToOwner[_zombieId].name = _newName;
  }
  function changeDna(uint _zombieId, uint _newDna) external abovelevel(20, _zombieId) onlyOwnerOf(_zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombieToOwner[_zombieId].dna = _newDna;
  }
  function getZombiesByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    uint counter = 0;
    for (uint256 i = 0; i < zombies.length; i.add(1)) {
      if(zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter.add(1);
      }
    }
    return result;
  }

}