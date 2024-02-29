pragma solidity ^0.8.9;
interface IPrngSystemContract {
    function getPseudorandomSeed() external returns (bytes32);
}

contract Prng {
    IPrngSystemContract constant PrngSystemContract =
        IPrngSystemContract(address(0x169));

    event RandomResult(bytes32, uint256);

    function getPseudorandomSeed() public returns (bytes32 randomBytes) {
        randomBytes = PrngSystemContract.getPseudorandomSeed();
    }
    
    function getPseudorandomNumber(
        uint256 lo_,
        uint256 hi_
    ) public returns (uint256 num) {
        bytes32 randomBytes = getPseudorandomSeed();
        num = uint256(randomBytes);
        num = lo_ + (num % (hi_ - lo_));
        emit RandomResult(randomBytes, num);
    }
}

