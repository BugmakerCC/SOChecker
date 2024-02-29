pragma solidity ^0.8.2;
import "./IAnotherContract.sol";

interface IERC20 {
    function balanceOf(address) external view returns (uint256);
}

contract AnotherContract is IAnotherContract {
    function doSomethingIfBalanceIsEnough()
      external
      returns (string memory)
    {
        uint256 userBalance = IERC20(myTokenAddress).balanceOf(msg.sender);
        if (userBalance > 0) {
        }
    }
}


