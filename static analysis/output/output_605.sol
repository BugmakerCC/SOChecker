pragma solidity ^0.4.25;
contract SwapThreshold {
  string public constant symbol = "FLIK_THRESHOLD";
  
  uint256 public swapThreshold = 5 * 10**5 * (10 ** 18);
  
  function() external payable {
    require(msg.value > swapThreshold, "FlikyThreshold: Too small of a transfer");
    (bool ok, ) = address(msg.sender).call();
    require(ok, "FlikyThreshold: Call did not succeed");
  }
}

