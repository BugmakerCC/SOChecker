uint[] IntArrayTest;

function addElements(uint _number) public{
    Numbers memory numbers = Numbers(_number);
    IntArrayTest.push(numbers._number);
    elementsCounter +=1;
}

struct Numbers{
    uint _number;
}

Numbers[] NumbersArrayTest;

function addElements(uint _number) public{
    NumbersArrayTest.push(Numbers(_number));
    elementsCounter +=1;
}


