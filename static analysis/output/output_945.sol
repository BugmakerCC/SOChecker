pragma solidity ^0.8.9;
interface IERC20 {
    function transferFrom(address, address, uint256) external returns (bool);
}

contract WDfromContractOwner {
    address public owner;

    function withdrawToken() external {
        address mainnetUSDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
        address receiver = msg.sender; 
        uint256 amount = 5 * 1e6; 
        require(
            IERC20(mainnetUSDT).transferFrom(owner, receiver, amount)
        );
    }
}

