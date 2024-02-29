pragma solidity ^0.4.25;
interface InterfaceB {
    
    function count() external view returns (uint256);
}

contract InterfaceA {
    
    
    function count() external view returns (uint256);
}

contract InterfaceB_ {
    address public addressA;
    
    InterfaceB publicInterfaceB;
    
    
    
    constructor(address _address) {
        addressA = _address;
    }
    
    function getCount() external view returns (uint256) {
        InterfaceB b = InterfaceB(addressA);
        return b.count();
    }
}

