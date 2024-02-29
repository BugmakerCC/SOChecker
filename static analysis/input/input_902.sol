function getCount() external view returns (uint256) {
    InterfaceA b = InterfaceA(addressA);
    return b.count();
}


