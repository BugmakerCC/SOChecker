uint[] memory dynamicMemArray = new uint[](size);

function doesSomethingWithArray(uint x) ... {
    uint[] storage dynamicStorageArray;
    dynamicStorageArray.push(x); 
    ...
}


uint[][3] public dynamicStorageArrays; 
function doesSomethingWithArray(uint x) ... {
    uint[] storage dynamicStorageArray = dynamicStorageArrays[1];
    dynamicStorageArray.push(x);
    ...
}


