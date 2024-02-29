constructor(address _VRFCoordinator, address _LinkToken, bytes32 _keyhash)
public 
VRFConsumerBase(_VRFCoordinator, _LinkToken) 
ERC721("Snails", "SNAIL") 
{
    keyHash = _keyhash;
    fee = 0.1 * 10**18; 
    tokenCounter = 0;
}


