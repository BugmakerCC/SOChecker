pragma solidity ^0.8.9;
interface IERC20 {
    function balanceOf(address account) external view returns (uint balance);

    function transfer(address to, uint value) external returns (bool);

    function approve(address spender, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);

    event Approval(address indexed owner, address indexed spender, uint value);
}

interface IUniV3Router02 {
    function WETH() external pure returns (address);

    function weth() external view returns (uint);

    function ETH() external pure returns (address);

    function eth() external view returns (uint);

    function swapExactTokensForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function swapExactTokensForETH(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB)
        external
        pure
        returns (uint amountB);

    function quoteForCurrentReserves(uint amountA) external pure returns (uint amountB);

    function reserves() external view returns (uint reserve0, uint reserve1);

    function reserve0() external pure returns (uint reserve0);

    function reserve1() external pure returns (uint reserve1);
}

