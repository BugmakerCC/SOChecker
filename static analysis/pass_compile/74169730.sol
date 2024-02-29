pragma solidity ^0.8;

abstract contract A {
    function stake(address _userAddress, uint256 _amount) internal virtual {}
}


contract B is A {
    modifier updateRewards {
        _;
    }

    function callStake() external {
        stake(address(0x123), 1);
    }
    
    function stake(address _userAddress, uint256 _amount) internal override updateRewards {}
}

