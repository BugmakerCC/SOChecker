pragma solidity ^0.8.9;
contract MyContract {
    uint256[] public C;
    function setVal(string memory C_) public returns(uint[] memory ret1) {
        bytes memory b = bytes(C_);
        for (uint i = 0; i < b.length; i++) {
            if (b[i] >= 0x30 && b[i] <= 0x39) {
                C.push(uint256(uint8(b[i]) - 48));
            }
        }
        return C;
    }
}

