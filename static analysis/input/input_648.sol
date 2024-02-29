pragma solidity ^0.8;

contract Vehicle {
    function turnRight() virtual external {
        turnSteeringWheel();
    }
}

contract Car is Vehicle {
}

contract Motorbike is Vehicle {
    function turnRight() override external {
        turnHandlebar();
    }
}

pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyContract is ERC20 {
    constructor() ERC20("MyToken", "MyT") {}

    function decimals() override public pure returns (uint8) {
        return 2;
    }
}

pragma solidity ^0.8;

contract Parent {
    function foo() virtual public pure returns (uint) {
        return 1;
    }
}

contract Child is Parent {
    function foo() override public pure returns (uint) {
        return 2;
    }
}

contract Child2 is Parent {
    function foo() override public pure returns (uint) {
        uint returnedFromParent = super.foo();

        return returnedFromParent + 1;
    }
}


