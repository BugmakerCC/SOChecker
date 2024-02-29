pragma solidity ^0.8;

contract UniswapV2Pair {
}

contract MyContract {
    function createPair() external {
        bytes32 salt = 0x1234567890123456789012345678901234567890123456789012345678901234;
        address pair = address(
            new UniswapV2Pair{salt: salt}()
        );
    }
}

