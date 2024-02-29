if (ethToSend > 0) {
    payable(_projectWallet).transfer(ethToSend);
}
payable(_marketingWallet).transfer(ethToSend);

if (ethToSend > 0) {
    payable(_projectWallet).transfer(ethToSend);
    payable(_marketingWallet).transfer(ethToSend);
}

payable(_projectWallet).transfer(ethToSend / 2);
payable(_marketingWallet).transfer(ethToSend / 2);


