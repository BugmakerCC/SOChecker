contract A {
    function X() external virtual returns (uint256) {
        return 1;
    }
}

contract B is A {
    uint256 public constant override X = 2;
}

contract A {
    uint256 public immutable X;

    constructor(uint256 _x) {
        X = _x;
    }
}

contract B is A(2) {}


