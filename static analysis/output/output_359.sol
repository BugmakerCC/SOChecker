pragma solidity ^0.8.9;
contract TimestampTest {
   function getTimestampInHMS() public view returns (string memory) {
      uint256 timestamp = block.timestamp;
      uint256 _hours = (timestamp / 3600) % 24;
      uint256 _minutes = (timestamp / 60) % 60;
      uint256 _seconds = timestamp % 60;

      return string(abi.encodePacked(
         _hours < 10 ? "0" : "", toString(_hours), ":",
         _minutes < 10 ? "0" : "", toString(_minutes), ":",
         _seconds < 10 ? "0" : "", toString(_seconds)
      ));
   }

   function toString(uint256 val) internal pure returns (string memory) {
      if (val == 0)
         return "0";
      uint256 digits;
      uint256 tmp = val;
      while (tmp != 0) {
         digits++;
         tmp /= 10;
      }
      bytes memory newBuffer = new bytes(digits);
      while (val != 0) {
         digits -= 1;
         newBuffer[digits] = bytes1(uint8(48 + val % 10));
         val = val / 10;
      }
      return string(newBuffer);
   }
}

