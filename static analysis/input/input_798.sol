pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "./SUSHI.sol";

contract BNB is ERC20, Ownable, AccessControl{

    string tokenName = "BNB token";
    string tokenSymbol = "BNB";
    uint decimal = 2;
    uint initFund = ...;
    uint rate = 32;

    constructor() ERC20 (tokenName, tokenSymbol){
        _mint(msg.sender, initFund);
    }

    function setRate(uint _rate) public onlyOwner {
        rate = _rate;
    }
    function getRate() public view returns(uint) {
        return rate;
    }

    function buyBNB(uint _amount){
        address owner = owner();
        require(_amount * rate == msg.value)
        transfer(msg.sender, _amount)
    }
    function exchange(uint _amount){
        SUSHI sushi = SUSHI(address(this));
        uint sushiRate = sushi.getRate();
        require(sushi.balanceOf(msg.sender) >= _amount * sushiRate / rate)
        transfer(msg.sender, _amount);
    }
    
    receive() payable {}

}


