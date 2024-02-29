pragma solidity 0.8.7;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SafeMathTest {
    using SafeMath for uint256;

    function a(uint256 x) external pure returns (uint256 sum) {
        sum = x.add(1);
    }

    function b(uint256 x) external pure returns (uint256 sum) {
        sum = x + 1;
    }
}

contract SafeMathTest2 {
    using SafeMath for uint256;

    function b(uint256 x) external pure returns (uint256 sum) {
        sum = x.add(1);
    }

    function a(uint256 x) external pure returns (uint256 sum) {
        sum = x + 1;
    }
}


