pragma solidity ^0.4.25;
contract Fundraiser {
    string public name;

    constructor(string memory _name) public {
        name = _name;
    }

    function () external payable {
        selfdestruct(0);
    }
}

