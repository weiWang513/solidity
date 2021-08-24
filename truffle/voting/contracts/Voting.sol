pragma solidity >=0.4.21 <0.6.0;

contract Voting{
  mapping (bytes32=>uint8) public votesReceived;
  // 候选人列表
  bytes32[] public candidateList;
  modifier validCandidate(bytes32 _candidate) {
    for (uint256 i = 0; i < candidateList.length; i++) {
      if(candidateList[i] == candidate) {
        return true;
      }
      return false;
    }
    _
  }
  // 投票的构造函数
  constructor (bytes32[] memory candidateNames) public {
    candidateList = candidateNames;
  }
  // 查询某候选人的投票数
  function totalVotesFor(bytes32 candidate) view public returns (uint8) {
    // require(validCandidate());
    return votesReceived[candidate];
  }
  // 增加候选人票数
  function voteForCandidate (bytes32 candidate) public {
    // require(validCandidate());
    votesReceived[candidate]+=1;
  }
  // function validCandidate () pure public returns (bool) {
  // //   for (uint256 i = 0; i < candidateList.length; i++) {
  // //     if(candidateList[i] == candidate) {
  // //       return true;
  // //     }
  // //     return false;
  // //   }
  //   return true;
  // }
}