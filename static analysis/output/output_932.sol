pragma solidity ^0.8.9;
library SafeMath {
    function add(uint a, uint b) internal pure returns (uint) {
        return a + b;
    }

    
    function sub(uint a, uint b) internal pure returns (uint) {
        return a - b;
    }

    
    function mul(uint a, uint b) internal pure returns (uint) {
        return a * b;
    }

    
    function div(uint a, uint b) internal pure returns (uint) {
        return a / b;
    }

    
    function mod(uint a, uint b) internal pure returns (uint) {
        return a % b;
    }
}

interface Crossmint {
    function mint(address _to, uint256 _quantity) external payable;
}

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf (address account) external view returns (uint);
    
    function allowance(address account, address spender) external view returns (uint);
}

contract Ownable {
    address private owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    
    constructor () {
        owner = msg.sender;
    }

    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownership cannot be transferred to zero address");
        owner = newOwner;
        emit OwnershipTransferred(owner, newOwner);
    }
}

