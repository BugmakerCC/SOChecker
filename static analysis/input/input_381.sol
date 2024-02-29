pragma solidity 0.8.21;

contract B {
    constructor(address _permit, address _weth) {}
}

contract C {
    constructor(address _weth) {}
}

contract A is B, C {
    address public weth;

    constructor(address _weth, address _permit)
        B(_permit, _weth)
        C(_weth)
    {
        weth = _weth;
    }
}


