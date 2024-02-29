contract B {
    A a = Test(0x123abc...);

    funciton getAddressA() public view returns (address) {
        return address(a); 
    }
}


