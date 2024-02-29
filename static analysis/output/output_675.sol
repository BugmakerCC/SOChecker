pragma solidity ^0.8.9;
contract ADOptionV3 {
    
    string public name;
    string public symbol;
    address public admin;

    constructor(
        string memory _name,
        string memory _symbol,
        address _admin
    ) {
        name = _name;
        symbol = _symbol;
        admin = _admin;
    }

    

    modifier onlyAdmin() {
        require(msg.sender == admin, "onlyAdmin");
        _;
    }

    function setAdmin(address newAdmin) public onlyAdmin {
        admin = newAdmin;
    }
}

