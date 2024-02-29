function addToVIP(address[] calldata toAddAddresses) external onlyOwner
    {
        for (uint i = 0; i < toAddAddresses.length; i++) {
            monthlyVIP[toAddAddresses[i]] = true;
            
        }
    }

function addToVIP(address[] calldata toAddAddresses) external onlyOwner
    {
        for (uint i = 0; i < toAddAddresses.length; i++) {
            monthlyVIP[toAddAddresses[i]] = true;
            vip.push(toAddAddresses[i]);
        }
    }



