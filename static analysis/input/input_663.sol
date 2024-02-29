(bool success, bytes memory data) = msg.sender.call{value: balance}("");

(bool success, )

contract.call.value(...)(...)

{value: balance, gas: 1000000}

msg.sender.call{value: balance}(abi.encodeWithSignature("test(uint,address)", 1, msg.sender))

(bool success, ) = owner.call{value: item.price}("");
require(success, "Transfer failed");


