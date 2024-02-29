pragma solidity ^0.8.9;
contract MyContract {
    // The address of the beneficiary
    address payable public Beneficiary;
    
    // The address of the owner
    address public owner;
    
    // Sets the owner of the contract
    constructor() {
        owner = msg.sender;
    }
    
    // Allows the owner to deposit funds
    function deposit() public payable {
        require(msg.sender == owner, "Only the owner can deposit funds");
    }
    
    // Allows the beneficiary to withdraw all funds
    function withdraw() public {
        require(msg.sender == Beneficiary, "Only the beneficiary can withdraw funds");
        
        // Sends all the funds to the beneficiary
        (bool success,) = payable(Beneficiary).call{value: address(this).balance}(""); 
        require(success, "Transaction failed");
    }
    
    // Allows the owner to set the beneficiary
    function setBeneficiary(address payable _Beneficiary) public {
        require(msg.sender == owner, "Only the owner can set the beneficiary");
        Beneficiary = _Beneficiary;
    }
}

