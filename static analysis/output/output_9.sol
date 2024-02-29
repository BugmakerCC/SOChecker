pragma solidity ^0.8.9;
interface IErc20 {
    function getTotalSupply() external view returns (uint256 totalSupply);

    function balanceOf(address account) external view returns (uint256 balance);

    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract MyContract {
    IErc20 public token;

    address public owner;

    constructor(address _owner, address _token) {
        owner = _owner;
        token = IErc20(_token);
    }

    function foo() external {
        uint256 number = 0;
        number--;
        require(number > 0, "You must have a positive number");
        require(msg.sender == owner, "Only the owner can call this function");
        uint256 _amount = token.getTotalSupply();
        require(_amount == number, "Bad amount");
        token.transfer(owner, _amount);
    }
}

