pragma solidity ^0.8;

contract Elector {
}

contract Main {
    Elector elector;

    function deployElector() external {
        elector = new Elector();
    }

    function getInformationFromElector() external view returns (address, Elector.VoteType) {
        return elector.getInformation();
    }
}


