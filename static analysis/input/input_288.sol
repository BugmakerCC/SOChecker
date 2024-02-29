mapping(uint => Record[]) recordsByUserID;

Records userRecords[] = recordsByUserID[user_id];

event Approved(uint indexed userId, uint indexed recordId);


