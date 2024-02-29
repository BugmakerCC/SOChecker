function validateAdditionalCalldata() pure external returns (bool, address) {
    bytes memory additionalCalldataMemory = hex"0000000000000000000000000000000000000000000000000000000000000001";
    bool decoded1 = abi.decode(additionalCalldataMemory, (bool));
    address decoded2 = abi.decode(additionalCalldataMemory, (address));

    return (decoded1, decoded2);
}

pragma solidity ^0.8;

contract FooResolver {
    function validateAdditionalCalldata() external view returns (bool, address) {
        bytes memory additionalCalldataMemory = hex"0000000000000000000000000000000000000000000000000000000000000002";

        bool decoded1;
        try this.decodeToBool(additionalCalldataMemory) returns (bool decodedValue) {
            decoded1 = decodedValue;
        } catch {
            decoded1 = false;
        }

        address decoded2 = abi.decode(additionalCalldataMemory, (address));

        return (decoded1, decoded2);
    }

    function decodeToBool(bytes memory data) external pure returns (bool) {
        return abi.decode(data, (bool));
    }
}


