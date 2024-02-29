pragma solidity ^0.8.9;
contract UtilityContract {

    string[] public list1 = [
        "list1",
        "list2"
    ];

    string[] public list2 = [
        "list3",
        "list4",
        "list5"
    ];

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

}

