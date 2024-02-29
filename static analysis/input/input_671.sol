  function onTransferReceived(
    address from,
    uint tokensPaid,
    bytes4 selector
  ) public acceptedTokenOnly {
    if (selector == this.purchase.selector) {
      purchase(from, tokensPaid);
    } else {
      revert("Call of an unknown function");
    }
  }


