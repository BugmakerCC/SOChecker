pragma solidity ^0.8.7;

import "https:

contract TokenTransfer {
    IERC20 _token;

    constructor(address token) {
        _token = IERC20(token);
    }

    modifier checkAllowance(uint amount) {
        require(_token.allowance(msg.sender, address(this)) >= amount, "Error");
        _;
    }

    function depositTokens(uint _amount) public checkAllowance(_amount) {
        _token.transferFrom(msg.sender, address(this), _amount);
    }
    
    function stake(address to, uint amount) public {
        _token.transfer(to, amount);
    }

    function getSmartContractBalance() external view returns(uint) {
        return _token.balanceOf(address(this));
    }
    
}


