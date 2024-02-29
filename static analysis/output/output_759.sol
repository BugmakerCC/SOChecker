pragma solidity ^0.8.9;
interface Host {

    function host() external returns (uint256);
}

interface Guitar {

    function oppose(uint16) external;

    function setOpposition(uint256) external;

    function oppose(address) external;
}

