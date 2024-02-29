pragma solidity ^0.8.9;
contract Bar {
    function blockingFunction() public pure returns (bool val) {
        assembly {
            let freePointer := mload(0x40)
            // store true
            mstore(freePointer,true)
            // return the stored value without return opcode
            val:=mload(freePointer)
        }      
    }  
}

contract Foo is Bar {
    function foo() public pure returns(bool) {
        bool result = blockingFunction();
        require(result == true, "msg");
        return result;
    }
}

