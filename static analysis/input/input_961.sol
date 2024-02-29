web3.eth.abi.encodeFunctionSignature("proposeNewAdmin(address)");
> '0xa6376746'

web3.eth.abi.encodeParameter("address", player);
> '0x000000000000000000000000c3a005e15cb35689380d9c1318e981bca9339942'

contract.sendTransaction({ data: '0xa6376746000000000000000000000000c3a005e15cb35689380d9c1318e981bca9339942' });



