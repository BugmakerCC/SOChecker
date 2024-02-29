contract Test {
    address public user;
    error MyCustomError(address _address);

    function revertError() public view {
    if(user!=address(0)) 
    { 
        revert MyCustomError({_address: msg.sender});
        }
    }
 }


