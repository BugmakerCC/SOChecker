pragma solidity ^0.8.9;
contract Fundraiser {
    string public name;
    string public url;
    string public imageURL;
    string public description;
    address payable beneficiary; 
    address custodian; 
    
    constructor(
    string memory _name,
    string memory _url,
    string memory _imageURL,
    string memory _description,
    address payable _beneficiary,
    address _custodian
  )

   public{
    name = _name;
    url = _url;
    imageURL = _imageURL;
    description = _description;
    beneficiary = _beneficiary;
    custodian = _custodian;

         }
        }

