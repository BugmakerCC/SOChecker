(bool success, ) = address(token).call{value: 0 ether, gas: 90000}(abi.encodeWithSignature("transferFrom(address,address,uint256)", sender, address(this), _tokenAmount));
require(success, "transferfrom of token failed");

(bool success, ) = USDCADDRESS.call{value: 0 ether, gas: 70000}(abi.encodeWithSignature("transfer(address,uint256)", destinationAddress, _tokenAmount));
require(success, "transfer failed");```


