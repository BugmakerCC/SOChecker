pragma solidity ^0.8.0;

import "./ContractB.sol";

contract Counter is KeeperCompatibleInterface {
    ContractB public contractB;
    uint256 public counter;

    constructor(ContractB _contractBAddress) {
        contractB = _contractBAddress;
    }

    function performUpkeep(bytes calldata) external override {
        counter = counter + 1;
        contractB.setTokenName(counter);
    }
}


