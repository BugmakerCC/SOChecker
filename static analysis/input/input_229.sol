function stakeTokens(uint256 _amount,address _token) public{
        require(_amount>0,"Amount must be more than 0");
    
        IERC20(_token).transferFrom(msg.sender,address(this),_amount);
    }


