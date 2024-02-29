pragma solidity ^0.8.9;
library AddressUtil {
    function require(bool condition, string memory errorMessage) internal pure {
        require(condition, errorMessage);
    }

    function require(bool condition, string memory errorMessage, bytes memory reason) internal pure {
        require(condition, errorMessage);
    }

    function requireAttr(bytes32 attr, bool attrExists, string memory errorMessage) internal pure {
        require(attrExists, errorMessage);
    }
}

