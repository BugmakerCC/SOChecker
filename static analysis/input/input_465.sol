struct transaction {
    uint id;
    uint amount;
    address payable to;
    address initiatedBy;
    uint signersCount; 
    address[3] signedBy;
}

function initiateTransaction( address payable _to, uint _amount ) public onlyUser returns(uint txnId) {
    transaction memory newTxn;
    newTxn.id = ++txnCount;
    newTxn.amount = _amount;
    newTxn.to = _to;
    newTxn.initiatedBy = msg.sender;
    newTxn.signedBy[newTxn.signersCount++] = msg.sender;
}


