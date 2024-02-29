struct Note {
    uint datetime;
    bool done;
    string note;
}

mapping (address => Note[]) notesPerUser;


