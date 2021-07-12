pragma solidity ^0.5.0;
contract NoteContracts {
  mapping(address => string []) public notes;
  event NewNote(address, string note);
  event ModifyNote(address, uint index);
  // function addNote(string memory note) public {
  //   notes[msg.sender].push(note);
  //   emit NewNote(msg.sender, note);
  // }
  function addNote(string memory note) public {
    notes[msg.sender].push(note);
    emit NewNote(msg.sender, note);
  }
  function getNoteLen(address owner) public view returns (uint) {
    return notes[owner].length;
  }
  function modifyNote(address own, uint index, string memory note) public {
    require(own == msg.sender);
    notes[own][index] = note;
    emit ModifyNote(own, index);
  }
}