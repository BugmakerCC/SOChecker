pragma solidity ^0.8.9;
library Utils {

    function onDeposit() public view returns (uint256) {
        return msg.value;
    }

}

