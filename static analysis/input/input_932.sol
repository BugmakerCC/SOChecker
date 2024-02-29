    function mint(address _to, uint256 _quantity) 
        external  
        payable
        isCorrectPayment(_quantity)
        isAvailable(_quantity) 
    {
        mintInternal(_to, _quantity);
    }

    function mintInternal(address _to, uint256 _quantity) internal {
        for (uint256 i = 0; i < _quantity; i++) {
            uint256 tokenId = nextId.current();
            nextId.increment();

            _safeMint(_to, tokenId);

            emit Mint(tokenId);
        }
    } 

    modifier isCorrectPayment(uint256 _quantity) {
        require(msg.value == (price * _quantity), "Incorrect Payment Sent");
        _;
    }

    modifier isAvailable(uint256 _quantity) {
        require(nextId.current() + _quantity <= MAX_SUPPLY, "Not enough tokens left for quantity");
        _;
    }

    <CrossmintPayButton
        clientId="_YOUR_CROSSMINT_CLIENT_ID_"
        environment="staging"
        mintConfig={{
            totalPrice: "0.001",
            _quantity: "1"
    }}
    />


