pragma solidity ^0.8;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract Crowdsale {
    IERC20 public token;
    uint256 price; 

    constructor (address _token, uint256 _price) {
        token = IERC20(_token);
        price = _price;
    }

    function buy() external payable {
        uint256 amount = price * msg.value;
        token.transfer(msg.sender, amount);
    }
}


