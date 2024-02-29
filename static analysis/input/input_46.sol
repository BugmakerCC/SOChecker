function withdraw(address _recipient) public payable onlyOwner {
    payable(_recipient).transfer(address(this).balance);
}

booking_contract.functions.withdraw(recipient_address)


