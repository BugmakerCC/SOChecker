contract YourContract {
   
    function destruct(address addr) ownerOnly {
         selfdestruct(addr);
    }

}


