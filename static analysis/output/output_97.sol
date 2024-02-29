pragma solidity ^0.8.9;
contract Test {
    address public user;
    /// custom error
    error MyCustomError(address _address);

    function revertError() public view {
    // I just had to pass a valid condition. address(0)=0x0000000000000000000000000000000000000000
    // if(user) would give this error: "Type address is not implicitly convertible to expected type bool"
    if(user!=address(0)) 
    { 
        revert MyCustomError({_address: msg.sender});
        }
    }
 }

