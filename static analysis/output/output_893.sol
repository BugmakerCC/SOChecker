pragma solidity ^0.4.25;
contract Dtoken {
    function transfer(address to, uint256 amount) public returns (bool);
    function transferFrom(address from, address to, uint256 amount) public returns (bool);
}

contract SubDAO {
    constructor(uint _poolGap, uint _DAOID, address _owner, uint _rate, address _creator, Dtoken _token) public {
        // Constructor code here
    }
}

contract MyContract {
    function transferTokens(Dtoken _token) public {
        _token.transferFrom(address(this), address(this), 10);
    }

    function createSubDAO (uint _poolGap, uint _DAOID, uint _rate, Dtoken _token) public returns (address daoAddress) {
        SubDAO subDAO = new SubDAO(_poolGap, _DAOID, msg.sender, _rate, this, _token);
        daoAddress = address(subDAO);

        _token.transfer(daoAddress, 10);
    }
}

