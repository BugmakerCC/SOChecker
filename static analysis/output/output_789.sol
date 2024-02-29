pragma solidity ^0.8.9;
contract Adoption {
    address[16] public adopters;

    function adopt(uint petId) public returns (uint) {
        require(petId >= 0 && petId <= 15);

        adopters[petId] = msg.sender;

        return petId;
    }

    function getAdopters() public view returns (address[16] memory) {
        return adopters;
    }
    
    function returnPet(uint petId) public returns (uint) {
        require(petId >= 0 && petId <= 15);
        
        require(msg.sender == adopters[petId]);
        
        adopters[petId] = address(0);
        
        return petId;
    }

}

