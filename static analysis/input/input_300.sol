pragma solidity >=0.8.0;

contract Abi2Test {

    function getByte() public returns (bytes memory) {
        bytes4 func = bytes4(keccak256("callMe(uint256[])"));
        return abi.encode(func);
     }

    function getByte2() public returns (bytes memory) {
        bytes4 func = bytes4(keccak256("callMe(uint256[])"));
        return abi.encodePacked(func);
     }
}

pragma solidity >=0.8.0;

contract Abi2Test {

    event A(uint256);
    event Out(bytes);
    event Out1(bytes);

    function test() public {
        bytes4 func = bytes4(keccak256("callMe(uint256[])"));

        uint256[] memory arr = new uint256[](3);
        arr[0] = 3;
        arr[1] = 4;


        (bool res, bytes memory data) = address(this).call(abi.encodePacked(func, abi.encode(arr)));
        emit Out(data);
        require(res);
    }

    function callMe(uint256[] memory array) public {
            emit A(array.length);
            emit Out1(msg.data);
    }
}


