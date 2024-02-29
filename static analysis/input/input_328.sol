function withdrawFunds() public {
    require(msg.sender == owner, "Only the owner can withdraw funds.");
    payable(msg.sender).transfer(address(this).balance);
}


