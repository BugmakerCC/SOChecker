pragma solidity ^0.8.9;
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

