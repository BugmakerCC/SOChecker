project:/contracts/Fundraiser.sol:8:5 

project:/contracts/Fundraiser.sol:9:5

project:/contracts/Fundraiser.sol:18:5
project:/contracts/Fundraiser.sol:19:5

pragma solidity >0.4.23 <0.7.0;

contract Fundraiser{
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


