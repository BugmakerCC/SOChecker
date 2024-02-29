pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MyT") {
    }

    function transfer(address to, uint256 amount) override public payable returns (bool) {
    }
}


