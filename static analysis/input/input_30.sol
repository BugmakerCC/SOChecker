bytes4 private constant SELECTOR = bytes4(keccak256(bytes("transfer(address,uint256)")));

  nonPayableAddress.call(abi.encodeWithSignature("transfer(address,uint256)", 0xaddress, amount))

(bool success, bytes memory data) = contractAddress.call(
        abi.encodeWithSelector(SELECTOR, to, value)
    );


