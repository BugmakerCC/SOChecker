pragma solidity ^0.8.9;
interface ERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
}

contract TokenList {
    ERC20[] public tokenList;

    function getList() public view returns (ERC20[] memory) {
        return tokenList;
    }
}

