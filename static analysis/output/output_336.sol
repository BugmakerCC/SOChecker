pragma solidity ^0.8.9;
interface IERC20 {
    function approve(address spender, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract SafeApprove {
    
    function safeApprove(IERC20 token, address spender, uint256 value) internal returns (bool)
    {
        require(spender != address(0), "ERC20: approve from the zero address");
        
        if (token.allowance(msg.sender, spender) == 0) {
            return true;
        }
        if (token.approve(spender, value) == false) {
            revert("ERC20: Approval for ");
        }
        return true;
    }
    
}

