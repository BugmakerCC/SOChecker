pragma solidity ^0.4.25;
contract NoteTaker {
    struct Note {
        uint datetime;
        bool done;
        string note;
    }
    
    mapping (address => Note[]) notesPerUser;
    
    
    function addNote(string memory noteTitle, uint timestamp) public {
        Note note;
        note.datetime = timestamp;
        note.done = false;
        note.note = noteTitle;
        notesPerUser[msg.sender].push(note);
    }
    
}

