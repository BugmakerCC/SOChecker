   function invest(uint256 amount) payable external{

        recordTransaction(address(this), amount, false);
        recordTransaction(owner, amount, true);

        address payable contractAddress = payable(address(this));
        contractAddress.send(amount);
    }

function send_ETH(address payable recipient) payable public {
    uint256 minimumUSD = 0.01 * 1e18;
    require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
    
    this.invest(msg.value);
    this.fund(recipient);
}

   function invest() internal{

        recordTransaction(address(this), amount, false);
        recordTransaction(owner, amount, true);
    }

const transaction = {
 'to': '0x31B98D14007bDEe637298086988A0bBd31184523', 
 'value': 1, 
 'gas': 30000,
 'maxFeePerGas': 1000000108,
 'nonce': nonce,
};


