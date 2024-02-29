pragma solidity ^0.4.25;
contract Test {

    function returnStuff() public returns (uint256, uint256);

    function() external payable {
       ( , uint256 ourNum) = returnStuff();
       require(ourNum == 3, "Bad return from returnStuff");
    }

}

