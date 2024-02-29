pragma solidity ^0.8.9;
contract RemoveByIndex {
   uint[] public payees = [1, 2, 3, 4, 5];
   mapping (uint=>uint) public idToIndex; 
   function populateMapping() public {
        idToIndex[1]=0;
        idToIndex[2]=1;
        idToIndex[3]=2;
        idToIndex[4]=3;
        idToIndex[5]=4;
    }
    function removeByIndex(uint index) public returns(uint[] memory){
        uint lastPayeeIndex=payees.length-1;
        uint lastPayeeId=payees[lastPayeeIndex];
        uint idToBeRemoved=payees[index];
        payees[index]=lastPayeeId;
        idToIndex[lastPayeeId]=index;
        delete idToIndex[idToBeRemoved];
        payees.pop();
        return payees;
    }
}

