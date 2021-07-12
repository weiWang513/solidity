/// @title 定义ERC721
/// @author weiwang2513
/// @notice 添加ERC721一些功能、获取余额、检查token所属、转账
/// @dev Explain to a developer any extra details
pragma solidity >=0.4.25 <0.7.0;
import './zombieattack';
import './ERC721';
contract ZombieOwnership is ZombieBattle, ERC721 {

  mapping (uint=>address) zombieApprovals;
  /// @notice 获取用户账户余额
  /// @param _owner 用户 address
  /// @return 返回用户账户余额
  /// @inheritdoc	Copies all missing tags from the base function (must be followed by the contract name)
  function balanceOf(address _owner) public view returns (uint256 _balance) {
    // 1. 在这里返回 `_owner` 拥有的僵尸数
    return ownerZombieCount(_owner);
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    // 2. 在这里返回 `_tokenId` 的所有者
    return zombieToOwner(_tokenId);
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to].add(1);
    ownerZombieCount[_from].sub(1);
    zombieToOwner[_tokenId] = _to;
    Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    zombieApprovals[_tokenId] = _to;
    Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(zombieApprovals[_tokenId] == msg.sender);
    address _owner = ownerOf(_tokenId);
    _transfer(_owner, msg.sender, _tokenId);
  }
}
