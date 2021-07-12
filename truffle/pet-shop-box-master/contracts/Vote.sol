pragma solidity ^0.5.0;

contract Vote {
  mapping(address => bool) public voters;
  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }
  event voteEvent(uint indexed _candidateId);
  uint public candidatesCount = 0;
  mapping (uint => Candidate) public candidates;
  function addCandidate(string memory _name) private {
    candidatesCount++;
    candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
  }
  constructor () public {
    addCandidate('Nets');
    addCandidate('Bucks');
  }
  function getCandidateCount() public view returns (uint) {
    return candidatesCount;
  }
  function vote(uint _candidateId) public {
    require(!voters[msg.sender]);
    require(_candidateId > 0 && _candidateId <= candidatesCount);
    voters[msg.sender] = true;
    candidates[_candidateId].voteCount++;
    emit voteEvent(_candidateId);
  }
}