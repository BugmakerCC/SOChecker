function isArrayEven() public view returns(bool[] memory) {
    bool[] memory ret = new bool[](arr.length);

    for (uint i = 0; i < arr.length; i++) {
        ret[i] = bool((arr[i]%2 == 0));
    }

    return ret;
}


