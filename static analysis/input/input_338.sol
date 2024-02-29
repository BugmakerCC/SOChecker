function utilityFunction(string[2] storage _list1, string[3] storage _list2) internal pure returns (uint256 result) {

function entryPoint() public view returns (uint256) {
    string[] memory _list1 = new string[](2);
    _list1[0] = list1[0];
    _list1[1] = list1[1];

    string[] memory _list2 = new string[](3);
    _list2[0] = list2[0];
    _list2[1] = list2[1];
    _list2[2] = list2[2];

    return utilityFunction(_list1, _list2);
}

function utilityFunction(string[] memory _list1, string[] memory _list2) internal pure returns (uint256 result) {
}


