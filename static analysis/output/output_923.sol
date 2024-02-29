pragma solidity ^0.4.25;
contract ERC20Interface {

    function transfer(address recipient, uint256 amount) external;
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Owned {

    address private owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        owner = newOwner;
    }

}

