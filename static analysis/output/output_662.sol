pragma solidity ^0.8.9;
    abstract contract OwnershipProxy {
        address public proxy;
        address public origin;

        constructor(address _origin) {
            proxy = _origin;
            origin = _origin;
        }

        modifier onlyOrigin() {
            require(msg.sender == origin, "Not authorized");
            _;
        }

        modifier onlyProxy() {
            require(msg.sender == proxy, "Not authorized");
            _;
        }
    }

