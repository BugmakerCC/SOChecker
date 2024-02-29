contract RemoveByIndex {
   uint[] public payees = [1, 2, 3, 4, 5];
    function removeByIndex(uint index) public returns(uint[] memory){
        uint lastPayeeIndex=payees.length-1;
        uint lastPayeeId=payees[lastPayeeIndex];
        payees[index]=lastPayeeId;
        payees.pop();
         return payees ;
    }
}

 [1, 5, 3, 4, 5]

 [1, 5, 3, 4]

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
        return payees ;
    }
}


