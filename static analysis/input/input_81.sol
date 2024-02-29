    function PubtoAddr(string calldata str_) pure public returns(bytes20) {
        bytes memory b = bytes(str_);
        return( bytes20(uint160(uint256(keccak256(b)))) );
    } 


