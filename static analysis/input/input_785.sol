    function crossmint(address to, uint8 amount) external payable {
        uint256 total = oefbContract.totalSupply();
        oefbContract.mintNFT{value: msg.value}(amount);

        for (uint256 i = 0; i < amount; i++) {
            oefbContract.transferFrom(address(this), to, total + i);
        }
    }


