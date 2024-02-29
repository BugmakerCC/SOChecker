pragma solidity ^0.8.9;
contract Test {

    bytes public var_name;

    constructor() public {
        var_name = bytes("test");
    }
}

contract Test2 {

    bytes public var_name;

    constructor() public {
        var_name = bytes("hello");
    }

    function set_var_name() public {
        var_name = bytes("world");
    }
}

