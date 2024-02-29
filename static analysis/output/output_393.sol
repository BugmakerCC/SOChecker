pragma solidity ^0.4.25;
interface Sales {
    function getOngoingSales() external view returns(Sale[] memory);
}

contract Sale {
    struct Sale {
        address creator;
        bool ended;
        uint startTime;
        uint endTime;
    }

    Sales[] public sales;

    function() external payable {
        revert();
    }
}

