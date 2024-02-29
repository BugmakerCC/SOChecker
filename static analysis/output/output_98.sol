pragma solidity ^0.8.9;
    library SafeMath {
        function multiply (uint256 a, uint256 b) internal pure returns (uint256) {
	 if (a == 0) {
		 return 0;
	 }
	 uint256 c = a * b;
	 require(c / a == b, "SafeMath: multiplication overflow");
	 return c;
	 } 
    }

