pragma solidity ^0.8.9;
contract WRequestContract {
    struct WRequest {
        uint id;
        string description;
        bool completed;
    }

    WRequest[] public WRequestList;

    constructor() public {
        // Add some initial WRequests
        WRequestList.push(WRequest(1, "First WRequest", false));
        WRequestList.push(WRequest(2, "Second WRequest", false));
    }

    function getWRequest(uint _index) public view returns(WRequest memory) {
        return WRequestList[_index];
    }
}

