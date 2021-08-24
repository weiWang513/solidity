/// @title 管理僵尸、转移所有权
/// @author weiwang2513
/// @notice balabala
/// @dev ERC721
pragma solidity >=0.4.21 <=0.6.0;

import './ZombieAttack.sol';

import './erc721.sol';

contract ZombieOwnership is ZombieAttack, ERC721 {
  function balanceOf (address _owner) public view returns (uint256 _balance){
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner){
    return zombieToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint _tokenId) private {
    ownerZombieCount[_to].add(1);// += 1;
    ownerZombieCount[_from].sub(1);// -= 1;
    zombieToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }
  mapping (uint256 => address) zombieApprovals;
  function approve (address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    zombieApprovals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership (uint256 _tokenId) public {
    require(zombieApprovals[_tokenId] == msg.sender);
    _transfer(ownerOf(_tokenId), msg.sender, _tokenId);
  }

}