pragma solidity ^0.8;

contract MyContract {
    struct Struct1Type {
        uint8 number;
    }

    struct Struct2Type {
        uint16 number;
    }

    function callFunction(bytes calldata _data) external pure returns (Struct1Type memory, Struct2Type memory) {
        Struct1Type memory data1 = abi.decode(_data[:32], (Struct1Type));

        Struct2Type memory data2 = abi.decode(_data[32:], (Struct2Type));

        return (data1, data2);
    }
}

# two values: `1` and `2`
0x00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002

0: tuple(uint8): 1
1: tuple(uint16): 2


