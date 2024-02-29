pragma solidity ^0.8.9;
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

