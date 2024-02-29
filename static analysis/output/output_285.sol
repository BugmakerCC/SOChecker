pragma solidity ^0.4.25;
contract Request {

    string public descritption;
    address  public value;
    address  public recipient;
    bool public complete;

    constructor(string _descrption, address _value, address _recipient) public {
        descritption = _descrption;
        value = _value;
        recipient = _recipient;
        complete = false;
    }
}

