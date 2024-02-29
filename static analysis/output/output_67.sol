pragma solidity ^0.8.9;
contract EtherBridge {

    function transferEther(address receiver) external payable {
        payable(receiver).call{value: msg.value}("");
    }


    function transferEther() external payable {
        owner = payable(msg.sender);

        owner.call{value: msg.value}("");
    }

    address payable public owner;

    constructor(address _owner) {
        owner = payable(_owner);
    }
}

