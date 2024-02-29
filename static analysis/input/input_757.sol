contract Bar {
    function blockingFunction() public pure returns (bool val) {
        assembly {
            let freePointer := mload(0x40)
            mstore(freePointer,true)
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


