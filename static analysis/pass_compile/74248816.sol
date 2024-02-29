pragma solidity >=0.4.22 <0.9.0;

contract NullContract{
    address public constant NULLADDRESS = address(0);
    
    function retrieve() public pure returns(address){
        return (address(0));
    }
}

