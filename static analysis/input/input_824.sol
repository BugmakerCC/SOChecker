function reduce(uint256[] arr) pure internal returns (uint256 result){
    for (uint256 i = 0; i < arr.length; i++) {
        result += arr[i];
    }
 
    return;
}


