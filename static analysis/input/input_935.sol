function funFind() public view returns(uint) {
    uint temp;
    for(uint i = 0; i < arr.length; i++) {
        temp = arr[i];
        for(uint j = 0; j < arr.length; j++) {
            if((j != i) && (temp == arr[j])) {
                return temp;
            }
        }
    }
}


