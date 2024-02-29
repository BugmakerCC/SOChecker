
    function log(string memory p0, string memory p1, string memory p2) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string,string)", p0, p1, p2));
    }

    console.log("your format string %s %s", string(yourBytesVariable1), string(yourBytesVariable2));


