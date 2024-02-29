pragma solidity ^0.8.9;
contract StringConcatenation {
    function AppendString(string memory a, string memory b) public pure returns (string memory) {
        return string(abi.encodePacked(a, "-", b));
    }
}

