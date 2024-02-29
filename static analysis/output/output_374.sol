pragma solidity ^0.4.25;
interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract YourContract {
    IERC20 public tokenContract; 
    
    function YourContract() public {
        tokenContract = IERC20(0x7B23915091592061650352169472183736104356);
    }
    function pullTokens() external {
        tokenContract.transferFrom(msg.sender, address(this), amount);
    }

    
    uint256 public amount; 
}

