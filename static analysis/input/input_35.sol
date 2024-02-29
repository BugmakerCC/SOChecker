function getStudentInfo(uint256 num) public view returns (bytes32, student memory) {
    bytes32 key = student_Address[num];
    return (
        key,
        studentMap[key]
    );
}


