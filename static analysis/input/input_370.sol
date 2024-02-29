pragma solidity >0.4.23 <0.9.0;

import { Clones } from "@openzeppelin/contracts/proxy/Clones.sol";

contract NebCrewFactory {

    NebCrew[] public NebCrewAddresses;
    address public implementationAddress;
    function addNebCrew() public {

        NebCrew nebCrewAddress = NewCrew(Clones.clone(implementationAddress));

        nebCrewAddress.initialize(); 

        NebCrewAddresses.push(nebCrewAddress);
    }
}

contract NebCrew{

    address public crew;

    initialize() {
        require(crew == address(0), "already initialized");
        crew = msg.sender;
    }

    function welcomeCrew() public pure returns (string memory _greeting) {
        return "Welcome to the truth...";
    }
}


