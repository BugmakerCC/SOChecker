0x
0000000000000000000000000000000000000000000000000000000000000062
0000000000000000000000000000000000000000000000000000000000000061
000000000000000000000000000000000000000000000000000000000000007a

0x
0000000000000000000000000000000000000000000000000000000000000020 # pointer
0000000000000000000000000000000000000000000000000000000000000003 # length
62617a0000000000000000000000000000000000000000000000000000000000 # value

pragma solidity ^0.8;

contract MyContract {
    function compare() external pure returns (bool) {
        uint8[3] memory foo = [98, 97, 122]; 
        string memory bar = "baz";

        bytes memory barBytes = bytes(bar);

        if (foo.length != barBytes.length) {
            return false;
        }

        for (uint i; i < foo.length; i++) {
            uint8 barItemDecimal = uint8(barBytes[i]);
            if (foo[i] != barItemDecimal) {
                return false;
            }
        }

        return true;
    }
}


