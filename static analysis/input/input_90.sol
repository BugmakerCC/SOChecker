function showStakeAmount() external view returns(uint256){
    return StakingAmountOfUsers(msg.sender);
}

interface StakingInterface{
    function showStakeAmount() external view returns(uint256);
}

contract CMRGachaSeedNFT is ERC721URIStorage, AccessControl, ERC721Enumerable {
    uint256 AmountThatShouldBeStaked;

    StakingInterface StakingContract;

    constructor(address STAKING_CONTRACT_ADDRESS){
        StakingContract = StakingInterface(STAKING_CONTRACT_ADDRESS);
    }
    
    modifier isStaked(){
        require(StakingContract.showStakeAmount() > AmountThatShouldBeStaked, "You did not stake enough amount of X token");
        _;
    }

    function mintItem(address _address, string memory _tokenURI)
        public
        onlyRole(CONTRACT_ROLE)
        returns (uint256)
        isStaked()
    {
    }
}


