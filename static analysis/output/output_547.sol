pragma solidity ^0.4.25;
contract ercToken {
    function transfer(address _to, uint256 _value) public returns (bool);
    function balanceOf(address _owner) public view returns (uint256 balance);
}

contract Staking {

    ercToken etherToken;

    address public owner;
    address public staker;

    event Staked(address indexed staker);
    event Unstaked(address indexed staker);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(address _owner) public {
        owner = _owner;
    }

    function stake(uint256 _amount) public payable onlyOwner {
        owner.transfer(_amount);
        etherToken.transfer(address(etherToken), _amount);
    }

    function() payable public {
        owner.transfer( msg.value );
    }
}

