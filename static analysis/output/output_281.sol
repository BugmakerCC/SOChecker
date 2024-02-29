pragma solidity ^0.8.9;
interface IERC20 {

    function totalSupply() external view returns (uint256 totalsupply);
    function decimals() external view returns (uint8 decimals);


    function balanceOf(address account) external view returns (uint256 balance);
    function transfer(address recipient, uint256 amount) external returns (bool success);
    function allowance(address owner, address spender) external view returns (uint256 remaining);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool success);
    function approve(address spender, uint256 amount) external returns (bool success);
    function getApproved(address spender) external view returns (uint256 remaining);
}

interface IISwapRouter02 {
    
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    )
        external
        payable
        returns (uint amountTokenTaken, uint ethAmountReturned, uint amountTokenLeft);

    function swapExactETHForTokens(
        address token,
        uint amountTokenDesired,
        uint amountETHMin,
        address to,
        uint deadline
    )
        external
        payable
        returns (uint amountTokenReceived, uint ethAmountReturned, uint amountTokenLeft);

    function swapExactTokensForETH(uint amountTokenDesired)
        external
        returns (uint ethAmountReceived, uint amountTokenLeft);
}

