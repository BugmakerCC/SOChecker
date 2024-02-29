pragma solidity ^0.8.9;
interface SampleInterface {
    struct Point {
        uint x;
        uint y;
    }
    function setPoint(Point memory point) external;
    function getPoint() external view returns (Point memory);
}

contract SampleContract {
    SampleInterface private sample;

    constructor(address _sample) {
        sample = SampleInterface(_sample);
    }

    function setPoint(SampleInterface.Point memory point) external {
        sample.setPoint(point);
    }

    function getPoint() external view returns(SampleInterface.Point memory) {
        return sample.getPoint();
    }
}

