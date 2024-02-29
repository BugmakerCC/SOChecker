function getUnitSum() public view returns (uint) {
    uint sum;

    for (uint i = 0; i < details.length; i++) {
        sum += details[i].Unit;
    }

    return sum;
}


