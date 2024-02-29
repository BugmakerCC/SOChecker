function AcceptPayment(uint32 amount) public {
   bool success = tokenUSDC.transferFrom(msg.sender, address(this), amount * priceCapsule);
   require(success, "Could not transfer token. Missing approval?");
   bulkMint(_msgSender(), amount);
}


