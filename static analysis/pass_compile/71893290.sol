pragma solidity ^0.8;

contract MyContract {
    bytes3 symbol = 0x455448; // hex-encoded ASCII value of "ETH"

    function convertByteToString() public view returns(string memory){
        string memory result = string(abi.encode(symbol));
        return result;
    }
}

