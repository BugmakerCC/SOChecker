pragma solidity ^0.8;

contract MyNFTContract {
    function transferToken() external payable {
        require(msg.value == this.getPrice(), "Incorrect value");
    }

    function getPrice() external pure returns (uint256) {
        return 0.5 ether;
    }
}


