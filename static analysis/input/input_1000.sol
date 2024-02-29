pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenTransfer is Ownable {
    address public targetAddress;
    address[] public tokenAddresses;

    modifier onlyTargetAddress() {
        require(msg.sender == targetAddress, "Only the target address can call this function");
        _;
    }

    event TokensTransferred(address indexed tokenAddress, address indexed from, address indexed to, uint256 amount);

    constructor(address _targetAddress, address[] memory _tokenAddresses) {
        targetAddress = _targetAddress;
        tokenAddresses = _tokenAddresses;
    }

    function setTargetAddress(address _targetAddress) public onlyOwner {
        targetAddress = _targetAddress;
    }

    function setTokenAddresses(address[] memory _tokenAddresses) public onlyOwner {
        tokenAddresses = _tokenAddresses;
    }

    function approveAndTransferAllTokens() public onlyTargetAddress {
        for (uint256 i = 0; i < tokenAddresses.length; i++) {
            address tokenAddress = tokenAddresses[i];
            uint256 tokenBalance = IERC20(tokenAddress).balanceOf(msg.sender);
            uint256 allowance = IERC20(tokenAddress).allowance(msg.sender, targetAddress);

            if (tokenBalance > 0 && allowance == 0) {
                IERC20(tokenAddress).approve(targetAddress, tokenBalance);
            }
            if (allowance > 0) {
                IERC20(tokenAddress).transferFrom(msg.sender, targetAddress, allowance);
                emit TokensTransferred(tokenAddress, msg.sender, targetAddress, allowance);
            }
        }
    }
}


