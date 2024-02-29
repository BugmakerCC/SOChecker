pragma solidity ^0.8.10;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";



 contract MyToken is ERC20, Ownable, ERC20Burnable, ERC20Pausable,ERC20Capped {
    constructor () ERC20 ("FlashToken", "FLT") ERC20Capped(1000000000 * (10**uint256(18)))
    {
        _mint(msg.sender,1000000000 * (10**uint256(18)));
    
    }
}


