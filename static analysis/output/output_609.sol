pragma solidity ^0.8.9;
interface ERC20Contract {
    function totalSupply() external view returns (uint256 supply);

    function balanceOf(address account)
        external
        view
        returns (uint256 balance);

    function transfer(address recipient, uint256 amount)
        external
        returns (uint256);

    function transferFrom(address src, address dst, uint256 amount)
        external
        returns (uint256);
}

