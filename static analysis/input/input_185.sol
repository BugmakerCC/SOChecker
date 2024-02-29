function decode(bytes memory data) private pure returns(bytes4 selector, uint productAmount, bytes3 color) {
    assembly {
      selector := mload(add(data, 32))
      productAmount := mload(add(data, 64))
      color := mload(add(data, 96))
    }
}

(bytes4 selector, uint productAmount, bytes3 color) =
  decode(data);

bytes memory funcData =
  abi.encodeWithSelector(selector, sender, tokensPaid, productAmount, color);

(bool success,) = address(this).call(funcData);
require(success, "call failed");

if (selector == this.buy.selector) {
    buy(sender, tokensPaid, productAmount, color);
}

function onTransferReceived(address operator, address sender, uint256 tokensPaid, bytes calldata data) external override (IERC1363Receiver) returns (bytes4) {
    require(msg.sender == address(acceptedToken), "I accept purchases in Payable Tokens");
​
    (bytes4 selector, uint productAmount, bytes3 color) =
        decode(data);
​
    if (selector == this.buy.selector) {
      buy(sender, tokensPaid, productAmount, color);
    }
​
    return this.onTransferReceived.selector;
  }


