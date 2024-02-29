pragma solidity ^0.4.25;
interface IBinaryCrew {
    function welcomeCrew() external returns (string memory);
}

interface IClones {
    function clone(address) external returns (address);
}

contract NewCrew {

    function initialize() public pure;
}

contract IFactory {
    function create(address) external returns (address);
}

