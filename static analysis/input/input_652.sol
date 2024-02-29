address previousOwner;

function reclaimOwnership() external {
    require(msg.sender == previousOwner);
    owner = msg.sender;
}


