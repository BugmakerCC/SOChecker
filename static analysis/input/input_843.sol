pragma solidity 0.8.12;

contract StringConcatation {
    function AppendString(string memory a, string memory b) public pure returns (string memory) {
        return string.concat(a,"-",b);
    }
}



