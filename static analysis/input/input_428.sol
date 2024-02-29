    console.logBytes4(bytes4(keccak256(bytes("foo2(uint256)")))); 
    console.logBytes(abi.encodeWithSignature("foo2(uint256)")); 
    console.logBytes4(Token2.foo2.selector); 


