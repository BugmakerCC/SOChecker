interface IPrngSystemContract {
    function getPseudorandomSeed() external returns (bytes32);
}

IPrngSystemContract constant PrngSystemContract =
    IPrngSystemContract(address(0x169));

pragma solidity ^0.8.18;

interface IPrngSystemContract {
    function getPseudorandomSeed() external returns (bytes32);
}

contract Prng {
    IPrngSystemContract constant PrngSystemContract =
        IPrngSystemContract(address(0x169));

    event RandomResult(bytes32 randomBytes, uint256 num);

    function getPseudorandomSeed() public returns (bytes32 randomBytes) {
        randomBytes = PrngSystemContract.getPseudorandomSeed();
    }
    
    function getPseudorandomNumber(uint256 lo, uint256 hi) external returns (uint256 num) {
        bytes32 randomBytes = getPseudorandomSeed();
        num = uint256(randomBytes);
        num = lo + (num % (hi - lo));
        emit RandomResult(randomBytes, num);
    }
}



