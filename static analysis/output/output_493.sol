pragma solidity ^0.8.9;
contract RecordsManager {
  
  struct Records
   {
    address patientAddress;
    bool status;
    address hospital;
    uint admissionDate;
    uint dischargeDate;
    uint visitReason;
  }
   
  Records[] internal records;  
  Records[] internal record;
  Records[] internal newrecord;  
  
  
  address[] internal recordids;
  int internal recordID;
  bool internal _pause = true;
  uint public recordCount;
  
  
  
  mapping(address => Records[]) internal recordById;
}

