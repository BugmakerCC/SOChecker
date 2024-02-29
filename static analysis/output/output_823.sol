pragma solidity ^0.8.9;
contract Abicoder {
    function convert(bytes32 foo) public pure returns(string memory) {
    string memory bar = string(abi.encodePacked(foo));
    return bar;
 }

 function bytes32ToString(bytes32 _bytes32) public pure returns (string memory) {
        uint8 i = 0;
        while(i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }
}

