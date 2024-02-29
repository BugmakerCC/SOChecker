contract test {
    address[] arr1 = [0x778E08a594887B208d18a429cfD30d740e0fea71, 0xE8088D6c465Eaa58E123aa08623abaAFFBBBB55B];
    
    function arrayFunction() public pure{
        address[] memory arr2 = new address[](2);
        arr2[0] = 0x778E08a594887B208d18a429cfD30d740e0fea71;
        arr2[1] = 0xE8088D6c465Eaa58E123aa08623abaAFFBBBB55B;
    }
}


