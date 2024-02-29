mapping(uint256 => address) public staked;
mapping(address => uint256[]) stakedByAdddress;

function stake(uint256[] memory tokenIds) external {
    staked[tokenIds[i]] = msg.sender;
    stakedByAdddress[msg.sender].push(tokenIds[i]);
}


