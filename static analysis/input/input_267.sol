function setPoint(SampleInterface.Point memory point) external {
    SampleInterface(sample).setPoint(point);
}

function getPoint() external view returns(SampleInterface.Point memory) {
    return SampleInterface(sample).getPoint();
}


