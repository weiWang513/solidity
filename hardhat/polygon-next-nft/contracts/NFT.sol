pragma solidity ^0.8.3;

import '@openzeppelin/contract/utils/Counters.sol';
import '@openzeppelin/contract/token/ERC721/extensions/ERC721URIStorage.sol';
import '@openzeppelin/contract/token/ERC721/ERC721.sol';


import 'hardhat/console.sol';

contract NFT is ERC721URIStorage {
  using Counter for Counters.Counter;
  Counters.Counter private _tokenIds;
  address contractAddress;

  constructor(address marketContractAddress) ERC721('Metaverse Token', 'METT') {
    contractAddress = marketContractAddress;
  }

  function createToken(string memory tokenURI) public returns(uint) {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();

    _mint(msg.sender, newItemId);
    _setTokenURI(newItemId, tokenURI);
    setApprovalForAll(contractAddress, true);
    return newItemId;
  }
}