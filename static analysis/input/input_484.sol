import "../interfaces/IERC20.sol";

function stakeTokens(uint256 _amount,address _token) public{
    IERC20(_token).transferFrom(msg.sender,address(this),_amount);
 }


