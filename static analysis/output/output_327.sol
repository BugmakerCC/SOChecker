pragma solidity ^0.4.25;
contract Appliance {

    
    function toggleAppliance(uint256 id, bool status) public;
    
    function getAppliance(uint256 id) public view returns (bool status, bytes1 pin);
    
    function removeAppliance(uint256 id) public;
    
    function updateAppliance(uint256 id, string memory name, bytes1 pin) public;


    struct Appliance {
        bool status;
        bytes1 pin;
    }
}

contract Appliances {

    function getAppliancesCount() public view returns (uint256 count);
	
    function getAppliances() public view returns (Appliance[] memory);
    
    function addAppliance(string memory name, bytes1 pin) public payable returns (uint256 id);
    
    function removeAppliance(uint256 id) public;
    
    function toggleAppliance(uint256 id, bool status) public;
  
    function updateAppliance(uint256 id, string memory name, bytes1 pin) public;
	
  
    address owner;
    Appliance[] public appliances;

    constructor() public {   
        owner = msg.sender;
    }
}

