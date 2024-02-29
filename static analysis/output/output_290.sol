pragma solidity ^0.8.9;
interface IERC20 { 
    function transfer(address recipient, uint256 amount) external returns(bool);
}

contract MyContract {
    address public owner;
    mapping(address => uint256) public stakingBalance;
    IERC20 public USDc;

    constructor(IERC20 _usdc) public {
        owner = msg.sender;
        USDc = _usdc;
    }

    function withdrawalTokens(address _addressChange) public {
        require (msg.sender == owner);

        uint256 amountToWithdraw = stakingBalance[_addressChange];

        stakingBalance[_addressChange] = 0;

        USDc.transfer(msg.sender, amountToWithdraw);
    }
}

