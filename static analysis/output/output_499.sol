pragma solidity ^0.8.9;
contract PrimeNumber {
    function isPrimeNumber(uint num1) public view returns (bool) {
        bool result = true;
        assembly {
        for {let i := 2} lt(i, num1) {i := add(i, 1)}{
            if eq(mod(num1, i), 0) {
                result := 0
            }
        }
        }
        return result;
    }
}

