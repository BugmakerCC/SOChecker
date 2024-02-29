pragma solidity ^0.8.9;
contract YourContract {
    struct YourStruct {
        uint x;
        string y;
    }

    function func(
        uint a,
        uint b,
        string memory c,
        YourStruct memory d
    ) external pure returns (uint, uint, string memory, YourStruct memory) {
        return (a, b, c, d);
    }
}

