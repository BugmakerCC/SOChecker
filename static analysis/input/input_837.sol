abstract contract Initializable {
        bool private _initialized;
    
        modifier initializer() {
            require(!_initialized, "Initializable: co...");
            _;
            _initialized = true;
        }
    }
    
contract UpgradebleTestParent is Initializable {
    uint public x;

    function initialize(uint _x) internal initializer {
        x = _x;
    }
}

contract UpgradebleTestMain is UpgradebleTestParent {
    function init(uint _x) public initializer {
        initialize(_x);
    }
}


