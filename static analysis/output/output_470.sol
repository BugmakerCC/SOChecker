pragma solidity ^0.8.9;
interface IERC20 {
    function decimals () external view returns (uint8);

    function totalSupply () external view returns (uint);

    function balanceOf (address account) external view returns (uint);
    function transfer (address recipient, uint256 amount) external returns (bool);
    function allowance (address owner, address spender) external view returns (uint);
}

contract Test {
    IERC20 public  test ;

    function clearTest () public {
        delete test;
    }

}

