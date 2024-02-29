pragma solidity ^0.4.25;
contract ERC20 {
    
    function totalSupply() public view returns (uint256);
    
    function balanceOf(address account) public view returns (uint256);

    function transfer(address to, uint256 value) public returns (bool);

    function allowance(address owner, address spender) public view returns (uint256);

    function transferFrom(address from, address to, uint256 value) public returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Ownable {
    address public owner;
    
    
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: call via owner already");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }

}

