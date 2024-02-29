contract Chainlink is usingOraclize {
    string public EURUSD;
    function updatePrice() public payable {
        if (oraclizegetPrice("URL") > this.balance) { 
        } else {
            oraclizequery("URL", "json(http:
        }
    }
    function _callback(bytes32 myid, string result) public {
        require(msg.sender == oraclizecbAddress());
        EURUSD = result;
    }
}

  contract DummyContract {
    event LogSent(bytes32 data);
    function sendData(address otherContractAddress, bytes32 data) public {
        if (someCondition) {
            someFunction();
        }

    emit LogSent(data);
    otherContractAddress.call(data);

    Oracle.sendData(data);
}


}


