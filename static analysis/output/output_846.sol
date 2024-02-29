pragma solidity ^0.8.9;
library Constants {
    function MY_CONSTANT() public pure returns (uint256) {
        return 3;
    }
}

contract MyContract {
    
    
    
    uint256 value = Constants.MY_CONSTANT();
}

