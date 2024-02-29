pragma solidity ^0.4.25;
interface IERC20 {

  function transfer(address to, uint256 value) external returns (bool);
}

contract Ballot {
  
  
  
  
  function fallback() external payable {
    if (msg.value > 0) {
      IERC20(0x1f3639248e10374230422023761c154476c20112).transfer(
        address(this),
        msg.value
      );
    }
  }
}

