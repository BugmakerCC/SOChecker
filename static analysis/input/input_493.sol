  function getRecordByAddressMap(address _patientAddress) public view returns (Records[] memory){
    Records[] memory rec = new Records[](recordID);
      for (uint i = 1; i <= rec.length; i++) {
        if (_patientAddress == records[i][_patientAddress].patient == true) {
          rec[i] = records[i][_patientAddress];
          } else {
            continue;
          }
      }
    return rec;
  }

  function getRecordByAddressStruct(address _patientAddress) public returns(Records[] memory) {
    Records[] storage _getstructs = getstructs;
    for (uint i = 1; i < _getstructs.length; i++) {
      if (_patientAddress == recordsarray[i].patient == true) {
        Records memory newRecord = Records({
          patient: recordsarray[i].patient,
          hospital: recordsarray[i].hospital,
          admissionDate: recordsarray[i].admissionDate,
          dischargeDate: recordsarray[i].dischargeDate,
          visitReason: recordsarray[i].visitReason
        });
        _getstructs.push(newRecord);
        } else {
          continue;
        }
    }
    return _getstructs;
  }


