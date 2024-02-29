uint256[] memory points;

function _generateXPoints(uint256 pointsCount) public view returns (uint256[] memory) {
    uint256[] memory points = new uint256[](pointsCount);

    for(uint256 i; i < pointsCount; i++) {
      points[i] = 1;
    }

    return points;
}

uint256[][1] memory points;
points[0] = new uint256[](pointsCount);

function generatePoints(uint256 pointsCount) public view returns (uint256[][1] memory) {
    uint256[][1] memory points;
    points[0] = new uint256[](pointsCount);
    for(uint256 i; i < pointsCount; i++) {
        points[0][i] = 1;
    }

    return points;
}


