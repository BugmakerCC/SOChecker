pragma solidity ^0.8.9;
interface Token {
    event Approval(
        address indexed tokenAddress,
        address indexed from,
        address indexed to,
        uint tokens);

    function allowance(address owner, address spender)
        external
        view
        returns (uint);

    function transfer(address to, uint tokens)
        external
        returns (bool success);

    function transferFrom(
        address from,
        address to,
        uint tokens)
        external
        returns (bool success);

    function approve(address spender, uint tokens)
        external
        returns (bool success);

    function getApprovedTokens()
        external
        view
        returns (uint);
}

