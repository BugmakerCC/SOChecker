pragma solidity ^0.8.9;
    library SafeMath {
        function add(uint256 a, uint256 b) internal pure returns (uint256) {
            uint256 c = a + b;
            require(c >= a, "SafeMath: addition overflow");

            return c;
        }
        function sub(uint256 a, uint256 b) internal pure returns (uint256) {
            return a - b;
        }
        function mul(uint256 a, uint256 b) internal pure returns (uint256) {
            if (a == 0) {
                return 0;
            }

            uint256 c = a * b;
            require(c / a == b, "SafeMath: multiplication overflow");

            return c;
        }

        function div(uint256 a, uint256 b) internal pure returns (uint256) {
            return a / b;
        }

        function mod(uint256 a, uint256 b) internal pure returns (uint256) {
            return a % b;
        }
    }

    interface IMath {
        function add(uint256 a, uint256 b) external pure returns (uint256);
    }

