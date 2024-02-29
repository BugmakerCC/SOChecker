pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IRule {
    function rule (bytes32 data, address addr, 
       address[] memory addrArr, uint256[] memory uintArr, 
       bytes[] memory dataArr, string memory str)
    external view returns (bool);
}
contract Demo is Ownable {
    mapping(bytes32 => IRule)  public rules;
    function setRule(bytes32 role, IRule rule) public onlyOwner {
        rules[role] = rule;
    }
}


