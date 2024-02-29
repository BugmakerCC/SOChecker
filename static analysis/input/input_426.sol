if (msg.sender != owner()) {
        if (whitelisted[msg.sender] != true) {
            if (presaleWallets[msg.sender] != true) {
                require(msg.value >= cost * _mintAmount);
            } else {
                require(msg.value >= presaleCost * _mintAmount);
            }
        }
    }


