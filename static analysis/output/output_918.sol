pragma solidity ^0.8.9;
library Structs {
    struct AnyName {
        uint256 id;
    }
}

contract ContractA {
    Structs.AnyName go;
}

