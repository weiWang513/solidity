pragma solidity >=0.4.21 <=0.6.0;
import './Owned.sol';
import './TokenERC20.sol';

contract LotteryCoin is owned, TokenERC20 {
  uint256 public sellPrice;
  uint256 public buyPrice;

  mapping (address=>bool) public frozenAccount;

  event FrozenFunds(address target, bool frozen);

  constructor() TokenERC20(1e8, 'LotteryCoin', 'LTC') public {
    sellPrice = 1 finney;
    buyPrice = 1 finney;
  }

  function _transfer(address _from, address _to, uint _value) internal {
    require(_to != address(0x0));
    require(balanceOf[_from] >= _value);
    require(balanceOf[_to] + _value >= balanceOf[_to]);
    require(!frozenAccount[_from]);
    require(!frozenAccount[_to]);
    balanceOf[_from] += _value;
    balanceOf[_to] -= _value;
    emit Transfer(_from, _to, _value);
  }

  function mintToken(address target, uint256 mintedAmount) onlyOwner public {
    balanceOf[target] += mintedAmount;
    totalSupply += mintedAmount;
    emit Transfer(address(0), address(this), mintedAmount);
    emit Transfer(address(this), target, mintedAmount);
  }

  function freezeAccount(address target, bool freeze) onlyOwner public {
    frozenAccount[target] = freeze;
    emit FrozenFunds(target, freeze);
  }

  function setPrice(uint256 newSellPrice, uint256 newBuyPrice) onlyOwner public {
    sellPrice = newSellPrice;
    buyPrice = newBuyPrice;
  }

  function buy() payable public {
    uint amount = msg.value / buyPrice * 10 ** uint256(decimals);
    _transfer(address(this), msg.sender, amount);
  }

  function sell(uint256 a) payable public {
    address myAddress = address(this);
    uint256 amount = a * 10 ** uint256(decimals);
    require(myAddress.balance >= amount * sellPrice);
    _transfer(msg.sender, address(this), amount);
    msg.sender.transfer(amount * sellPrice);
  }
}