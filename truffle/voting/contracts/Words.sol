pragma solidity >=0.4.21 <=0.6.0;

contract Words{
  struct Item {
    string what;
    address who;
    uint when;
  }
  /// @notice 记录所有誓言数据
  /// @dev Explain to a developer any extra details
  /// @return Documents the return variables of a contract’s function state variable
  Item[] private allWords;
  /// @notice 保存誓言
  /// @dev Explain to a developer any extra details
  /// @return Documents the return variables of a contract’s function state variable
  function save(string memory _s, uint _t) public {
    allWords.push(Item({what: _s, who: msg.sender, when: _t}));
  }
  /// @notice 查询当前誓言总条数
  /// @dev Explain to a developer any extra details
  /// @return Documents the return variables of a contract’s function state variable
  function getSize() public view returns(uint) {
    return allWords.length;
  }
  /// @notice 根据编号查询具体
  /// @dev Explain to a developer any extra details
  /// @return Documents the return variables of a contract’s function state variable
  function getRandom(uint _random) public view returns(string memory, address, uint) {
    if (allWords.length == 0) {
      return('', msg.sender, 0);
    } else {
      Item storage result = allWords[_random];
      return(result.what, result.who, result.when);
    }
  }
}