pragma solidity ^0.4.25;
interface IERC20 {

    function INITIAL_SUPPLY() public pure returns(uint256);
}

contract SimpleERC20 {
    
    
    function getInitialSupply() public view returns (uint256) {
        return IERC20(0x320000000000000000000000000000000000000).INITIAL_SUPPLY();
    }
}

