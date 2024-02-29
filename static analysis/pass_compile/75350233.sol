// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Structure {
    struct BaseStruct {
        uint256 a;
        uint256 b;
    }

    struct DerivedStruct {
        BaseStruct base;
        uint256 c;
        uint256 d;
    }
}

