pragma solidity ^0.8.9;
interface Request {
    function accept() external;
}

contract Campaign {
    function getRequests() external view returns (Request[] memory) {
        return requests;
    }
    address private owner;
    address campaign;
    uint requestCount;
    Request[] requests;
    mapping(address => Request[]) requestsByAddress;
    event RequestsCreated(address[] callee, uint[] requests);

    constructor(address _campaign) {
        owner = msg.sender;
        campaign = _campaign;
    }
    
    modifier restricted() {
        require(owner == msg.sender || isManager(msg.sender), "Restricted function call");
        _;
    }
    
    function isManager(address account) public view returns(bool) {
        return msg.sender == owner || accounts[account];
    }
    
    mapping(address => bool) accounts;
    
    function addManager(address account) restricted public {
        accounts[account] = true;
    }

    function removeManager(address account) restricted public {
        require(accounts[account], "Account not manager");
        delete accounts[account];
    }
    
    receive() external payable {
    }
    
    fallback() external payable {
    }
}

