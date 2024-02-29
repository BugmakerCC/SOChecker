pragma solidity ^0.4.25;
interface CNameRecord {
    function addRecord(
        address _addr,
        string memory cname,
        string memory l_cadence,
        string memory r_cadence,
        string memory n_cadence,
        string memory l_dsupport,
        string memory r_dsupport,
        string memory n_dsupport,
        string memory l_footoff,
        string memory r_footoff,
        string memory n_footoff,
        string memory l_steptime,
        string memory r_steptime,
        string memory n_steptime,
        string memory admittedOn,
        string memory dischargedOn,
        string memory ipfs
    ) public;
}

