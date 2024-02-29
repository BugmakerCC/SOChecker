pragma solidity ^0.8.9;
interface ProvableAPI {

    function getBlockNumber() external view returns (int256);

}

contract SimpleProvableExample {

    ProvableAPI public provable;

    constructor(address _provable) {
        provable = ProvableAPI(_provable);
    }

    function queryNumber() public view returns (int256) {
        return provable.getBlockNumber();
    }

}

