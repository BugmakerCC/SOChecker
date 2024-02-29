pragma solidity ^0.4.25;
interface IValidation {
    function isValidCertificate(bytes data) view returns (bool);
}

contract Validation {

    modifier isValidCertificate(bytes data) {
        require(IValidation(msg.sender).isValidCertificate(data));
        _;
    }

    constructor() public {
    }

    function validate(bytes data) public isValidCertificate(data) {
        IValidation(msg.sender).isValidCertificate(data);
    }
}

