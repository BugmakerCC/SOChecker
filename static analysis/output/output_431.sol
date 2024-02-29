pragma solidity ^0.8;

contract MyNFTContract {
    function transferToken() external payable {
        require(msg.value == this.getPrice(), "Incorrect value");
        // ... 
    }

    function getPrice() external pure returns (uint256) {
        // can by also dynamic based on the token ID or any other on-chain param
        return 0.5 ether;
    }
}

