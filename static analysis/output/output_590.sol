pragma solidity ^0.8.9;
interface Payment {
    function setYearlySalary() external virtual;

    function setMonthlySalary() external virtual;

    function getMonthlySalary() external view returns (uint256);
}

